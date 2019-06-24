NODE_PACKAGE_NAME=nodejs
NODE_GPG_KEY_URL=https://deb.nodesource.com/gpgkey/nodesource.gpg.key
NODE_SOURCES_LIST=/etc/apt/sources.list.d/nodesource.list
NODE_ENV=production
NODE_VERSION="nodejs"

.PHONY: node-repos
node-repos:
	@$(MAKE) -s output-blue text="installing node repositories"
	@$(MAKE) -s apt-repo name="node" url="https://deb.nodesource.com/node_8.x" codename="trusty" components="main"
	@$(MAKE) -s apt-add-key url=$(NODE_GPG_KEY_URL)
	@$(MAKE) -s apt-update

.PHONY: node-build-deps
node-build-deps: ## install node dependencies for use in builds
	@$(MAKE) -s output-blue text="installing node dependencies"
	@$(MAKE) -s apt-install packages="$(NODE_VERSION)"

.PHONY: node-test
node-test:
	npm test

.PHONY: node-build
node-build: node-setup

.PHONY: node-setup
node-setup: node-npm-install ## setup npm for use in the project

.PHONY: node-npm-install
node-npm-install:
	npm install -g npm
	@if [ -f "assets/package.json" ] ; \
	then \
	 	cd 'assets'; npm install; \
	fi;

.PHONY: node-version
node-version: ## get the current node version being used
	@$(eval NODE_VERSION_CURRENT=$(shell sudo dpkg -s "$(NODE_PACKAGE_NAME)" | grep -i "version" | awk '{print $$2}'))
	@echo $(NODE_VERSION_CURRENT)

.PHONY: node-clean
node-clean: ## remove all npm packages in node_modules
ifdef CLEAN_ALL
	rm -rf "node_modules"
endif

CURFILE := $(shell dirname $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
ifeq ($(CURFILE), $(CURDIR))
include ../shared/*.mk
endif
