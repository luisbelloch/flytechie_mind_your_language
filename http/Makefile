.PHONY: all
all: dependencies up

.PHONY: up
up:
	RUBYOPT="-W0" bundle exec puma -t 8:32 -w 3 --preload

.PHONY: dependencies
dependencies:
	bundle install
