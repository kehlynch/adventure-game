SHELL=/bin/bash

.PHONY: setup
setup: check ## meta-target that invokes all targets matching "-setup", e.g. create a target called, my-setup, and will be be invoked will calling this target 
	@$(MAKE) -s run-tasks-filtered task-filter="-setup"

.PHONY: repos
repos: check ## meta-target that invokes all targets matching "-setup", e.g. create a target called, my-setup, and will be be invoked will calling this target 
	@$(MAKE) -s run-tasks-filtered task-filter="-repos"
	
.PHONY: build-deps
build-deps: check apt-update ## meta-target that invokes all targets matching "build-deps", e.g. create a target called, my-build-deps, and will be be invoked will calling this target
	@$(MAKE) -s run-tasks-filtered task-filter="-build-deps"

.PHONY: run-deps
run-deps: check apt-update ## meta-target that invokes all targets matching "-run-deps", e.g. create a target called, my-run-deps, and will be be invoked will calling this target
	@$(MAKE) -s run-tasks-filtered task-filter="-run-deps"

.PHONY: check
check: ## meta-target that invokes all targets matching "-check", e.g. create a target called, my-check, and will be be invoked will calling this target
	@$(MAKE) -s run-tasks-filtered task-filter="-check"

.PHONY: clean
clean: ## meta-target that invokes all targets matching "-clean", e.g. create a target called, my-clean, and will be be invoked will calling this target
	@$(MAKE) -s run-tasks-filtered task-filter="-clean"

run-tasks-filtered: set-list
	@for t in $(TASKS) ; do \
		if [[ -n "$$(echo "$$t" | grep "\$(task-filter)$$")" ]]; then \
			$(MAKE) -s $$t ; \
			if [[ $$? -gt 0  ]] ; then \
				exit 1 ; \
			fi ; \
		fi; \
	done

.PHONY: set-list
set-list:
	$(eval TASKS=$(shell $(MAKE) -pRrq -f Makefile : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'))

.PHONY: help
help:
	@grep -ohE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: output
output-blue:
	@echo -e "\033[34m\033[1m$(text)\033[0m"
