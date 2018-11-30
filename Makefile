MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.SUFFIXES:

ALL_TARGETS := $(shell egrep -o ^[0-9A-Za-z_-]+: $(MAKEFILE_LIST) | sed 's/://')

.PHONY: $(ALL_TARGETS)

catalog: ## Show catalog
	@echo -e "\033[36m$@\033[0m"
	@./catalog.sh

configure: ## Configure registry
	@echo -e "\033[36m$@\033[0m"
	@./provision.sh

start: ## Start registry
	@echo -e "\033[36m$@\033[0m"
	@docker-compose up -d

status: ## Show status
	@echo -e "\033[36m$@\033[0m"
	@docker-compose ps

stop: ## Stop registry
	@echo -e "\033[36m$@\033[0m"
	@docker-compose stop

restart: ## Restart registry
	@echo -e "\033[36m$@\033[0m"
	@docker-compose restart

shellcheck: ## Check for shell scripts
	@echo -e "\033[36m$@\033[0m"
	@shellcheck *.sh

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9A-Za-z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
