.PHONY: ruby
ruby:
	time ruby total_by_country.rb

.PHONY: sql
sql:
	time sqlite3 pancake_orders.sqlite "select source_country, sum(price) from pancake_orders group by source_country;"

.PHONY: pandas
pandas:
	time python total_by_country_pandas.py

.PHONY: parquet
parquet:
	time python total_by_country_parquet.py

.PHONY: clean
clean:
	rm -f pancake_orders.*.csv *.sqlite pancake_orders.10M

.PHONY: data
data: pancake_orders.sqlite pancake_orders.10.csv pancake_orders.1M.csv pancake_orders.10M

pancake_orders.10M.csv:
	ruby place_orders.rb

pancake_orders.10.csv: pancake_orders.10M.csv
	head -n 10 pancake_orders.10M.csv > $@

pancake_orders.1M.csv: pancake_orders.10M.csv
	head -n 1000000 pancake_orders.10M.csv > $@

pancake_orders.sqlite: pancake_orders.10M.csv
	sqlite3 -separator "," -header -batch $@ ".import pancake_orders.10M.csv pancake_orders"

pancake_orders.10M: pancake_orders.10M.csv dependencies
	python to_parquet.py

.PHONY: questdb_boot_and_load
questdb_boot_and_load:
	docker stop questdb && docker rm questdb
	docker run -d --name questdb -p 9000:9000 -p 9003:9003 questdb/questdb:7.3.5
	while [[ "$$(curl -s http://localhost:9003/status)" != *"Status: Healthy"* ]]; do sleep 5; done
	curl -F schema='[{"name":"ts", "type": "TIMESTAMP", "pattern": "yyyy-MM-dd''T''HH:mm:ss.UUUZ"}]' \
		-F data=@pancake_orders.10M.csv 'http://localhost:9000/imp?overwrite=true&name=pancake_orders&timestamp=ts'

questdb:
	time curl -G \
  	--data-urlencode "query=select source_country, sum(price) from pancake_orders group by source_country;" \
  	--data-urlencode "count=true" \
  	--data-urlencode "timings=true" \
  	http://localhost:9000/exec

requirements.txt:
	pip install pandas pyarrow tabulate
	pip freeze > requirements.txt

.PHONY: dependencies
dependencies: requirements.txt
	pip install -r requirements.txt
