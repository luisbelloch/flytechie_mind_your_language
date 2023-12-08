.PHONY: ruby
ruby:
	ruby total_by_country.rb

.PHONY: sql
sql:
	sqlite3 pancake_orders.sqlite "select source_country, sum(price) from pancake_orders group by source_country;"

.PHONY: pandas
pandas:
	python total_by_country_pandas.py

.PHONY: pyarrow
pyarrow:
	python total_by_country_pyarrow.py

.PHONY: clean
clean:
	rm -f pancake_orders.*.csv *.sqlite pancake_orders.10M.parquet

.PHONY: data
data: pancake_orders.sqlite pancake_orders.10.csv pancake_orders.1M.csv pancake_orders.10M.parquet

pancake_orders.10M.csv:
	ruby place_orders.rb

pancake_orders.10.csv: pancake_orders.10M.csv
	head -n 10 pancake_orders.10M.csv > $@

pancake_orders.1M.csv: pancake_orders.10M.csv
	head -n 1000000 pancake_orders.10M.csv > $@

pancake_orders.sqlite: pancake_orders.10M.csv
	sqlite3 -separator "," -header -batch $@ ".import pancake_orders.10M.csv pancake_orders"

pancake_orders.10M.parquet: pancake_orders.10M.csv
	python to_parquet.py

pancake_orders.duckdb:
	duckdb $@ -c "CREATE TABLE pancake_orders AS SELECT * FROM 'pancake_orders.10M.csv'";

.PHONY: duckdb
duckdb: pancake_orders.duckdb
	duckdb -list pancake_orders.duckdb -c "SELECT source_country, SUM(price) FROM pancake_orders GROUP BY source_country;"

.PHONY: questdb_boot_and_load
questdb_boot_and_load:
	docker stop questdb && docker rm questdb
	docker run -d --name questdb -p 19000:9000 -p 19003:9003 questdb/questdb:7.3.5
	while [[ "$$(curl -s http://localhost:19003/status)" != *"Status: Healthy"* ]]; do sleep 5; done
	curl -F schema='[{"name":"ts", "type": "TIMESTAMP", "pattern": "yyyy-MM-dd''T''HH:mm:ss.UUU"}]' \
		-F data=@pancake_orders.10M.csv 'http://localhost:19000/imp?overwrite=true&name=pancake_orders&timestamp=ts'

questdb:
	curl -G \
  	--data-urlencode "query=select source_country, sum(price) from pancake_orders group by source_country;" \
  	--data-urlencode "count=true" \
  	--data-urlencode "timings=true" \
  	http://localhost:19000/exec

CLICKHOUSE:=.clickhouse/clickhouse

$(CLICKHOUSE):
	mkdir -p .clickhouse
	curl https://clickhouse.com/ | sh
	mv clickhouse .clickhouse/

.PHONY: clickhouse_local_csv
clickhouse_local_csv: $(CLICKHOUSE)
	$(CLICKHOUSE) local -q "SELECT source_country, SUM(price) FROM file('pancake_orders.10M.csv') GROUP BY source_country;"

.PHONY: clickhouse_local_csv
clickhouse_local_parquet: $(CLICKHOUSE)
	$(CLICKHOUSE) local -q "SELECT source_country, SUM(price) FROM file('pancake_orders.10M.parquet', Parquet) GROUP BY source_country;"

.clickhouse/user_files/pancake_orders.10M.parquet:
	ln -s ../../pancake_orders.10M.parquet $@

.PHONY: clickhouse_server
clickhouse_server: $(CLICKHOUSE)
	cd .clickhouse && ./clickhouse server

.PHONY: clickhouse_load
clickhouse_load: $(CLICKHOUSE) .clickhouse/user_files/pancake_orders.10M.parquet
	$(CLICKHOUSE) client -h localhost --queries-file clickhouse_load.sql

.PHONY: clickhouse
clickhouse: $(CLICKHOUSE)
	$(CLICKHOUSE) client -h localhost --query "select source_country, sum(price) from pancake_orders group by source_country;"

requirements.txt:
	pip install pandas pyarrow
	pip freeze > requirements.txt

.PHONY: dependencies
dependencies: requirements.txt
	pip install -r requirements.txt

.PHONY: benchmark
benchmark:
	hyperfine --warmup 1 --runs 3 "make clickhouse_local_parquet" "make clickhouse_local_csv" "make clickhouse" "make duckdb" "make sql" "make pandas" "make pyarrow" "make questdb"
