MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.SUFFIXES:

ALL_TARGETS := $(shell egrep -o ^[0-9A-Za-z_-]+: $(MAKEFILE_LIST) | sed 's/://')

.PHONY: $(ALL_TARGETS)

configure: ## Configure registry
	@echo -e "\033[36m$@\033[0m"
	@./configure.sh

start: ## Start registry
	@echo -e "\033[36m$@\033[0m"
	@./docker-compose-wrapper.sh up -d

status: ## Show status
	@echo -e "\033[36m$@\033[0m"
	@./docker-compose-wrapper.sh ps

stop: ## Stop registry
	@echo -e "\033[36m$@\033[0m"
	@./docker-compose-wrapper.sh stop

restart: ## Restart registry
	@echo -e "\033[36m$@\033[0m"
	@./docker-compose-wrapper.sh restart

shellcheck: ## Check for shell scripts
	@echo -e "\033[36m$@\033[0m"
	@shellcheck *.sh

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9A-Za-z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
