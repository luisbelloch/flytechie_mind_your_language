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
data: pancake_orders.sqlite pancake_orders.10.csv pancake_orders.1M.csv

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


requirements.txt:
	pip install pandas pyarrow tabulate
	pip freeze > requirements.txt

.PHONY: dependencies
dependencies: requirements.txt
	pip install -r requirements.txt
