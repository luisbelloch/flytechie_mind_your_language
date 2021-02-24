PSQL:=docker run -e PGPASSWORD=pancakes -ti --network host postgres psql -d pancakes -h 127.0.0.1 -U postgres

.PHONY: all
all: dependencies up

.PHONY: up
up:
	RUBYOPT="-W0" bundle exec puma -t 4:8 -w 3 --preload

.PHONY: order
order:
	http -v :9292/orders/create flavour=banana size=XL

.PHONY: bench
bench:
	wrk --latency -s create_order.lua http://localhost:9292/orders/create

.PHONY: dependencies
dependencies:
	bundle install
	go get github.com/segmentio/ksuid
	go get github.com/lib/pq

.PHONY: postgres
postgres:
	docker run \
		-v $(PWD)/schema.sql:/docker-entrypoint-initdb.d/schema.sql \
		-e POSTGRES_DB=pancakes -e POSTGRES_PASSWORD=pancakes \
		-p 5432:5432 -ti postgres

.PHONY: psql
psql:
	$(PSQL)

.PHONY: empty_db
empty_db:
	$(PSQL) -c "DELETE FROM orders;"

.PHONY: pool
pool:
	$(PSQL) -c "SELECT pid,application_name, client_addr, state, query FROM pg_stat_activity where datname = 'pancakes' and application_name != 'psql';"
