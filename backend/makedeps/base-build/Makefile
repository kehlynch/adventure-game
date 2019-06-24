.PHONY: base-repos
base-repos:
	@$(MAKE) -s apt-update
	@$(MAKE) -s output-blue text="installing base repositories"

.PHONY: base-build-deps
base-build-deps:
	@$(MAKE) -s output-blue text="installing base dependencies"
	@$(MAKE) -s apt-install packages="curl git sudo make openssl python-pip build-essential gcc apt-transport-https dialog python-software-properties software-properties-common"

.PHONY: base-run-deps
base-run-deps: base-build-deps

CURFILE := $(shell dirname $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
ifeq ($(CURFILE), $(CURDIR))
include ../shared/*.mk
endif
