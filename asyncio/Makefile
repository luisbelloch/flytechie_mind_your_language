.PHONY: build
build:
	docker-compose build
	bundle install
	yarn

.PHONY: build_consumer_rb
build_consumer_rb:
	docker build -f Dockerfile.consumer_rb -t luisbelloch/consumer_rb .

.PHONY: consumer_rb
consumer_rb:
	docker run -v $(PWD):/opt/consumer --network host -ti luisbelloch/consumer_rb bash

.PHONY: build_consumer_js
build_consumer_js:
	docker build -f Dockerfile.consumer_js -t luisbelloch/consumer_js .

.PHONY: consumer_js
consumer_js:
	docker run -v $(PWD):/opt/consumer --network host -ti luisbelloch/consumer_js bash

.PHONY: up
up:
	docker-compose up --remove-orphans --force-recreate

.PHONY: down
down:
	docker-compose down --remove-orphans -v

