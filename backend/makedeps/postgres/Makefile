POSTGRES_CLIENT_VERSION=9.6
POSTGRES_GPG_KEY_URL=https://www.postgresql.org/media/keys/ACCC4CF8.asc

.PHONY: postgres-repos
postgres-repos:
	@$(MAKE) -s output-blue text="installing postgres repositories"
	@$(MAKE) -s apt-repo name="postgres" url="http://apt.postgresql.org/pub/repos/apt/" codename="trusty-pgdg" components="main" 
	@$(MAKE) -s apt-add-key url=$(POSTGRES_GPG_KEY_URL)
	@$(MAKE) -s apt-update

.PHONY: postgres-build-deps
postgres-build-deps: ## installs postgres dependencies
	@echo "installing postgres dependencies"
	@$(MAKE) -s apt-install packages="postgresql-client-$(POSTGRES_CLIENT_VERSION)"

.PHONY: postgres-run-deps
postgres-run-deps: postgres-build-deps

CURFILE := $(shell dirname $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
ifeq ($(CURFILE), $(CURDIR))
include ../shared/*.mk
endif
