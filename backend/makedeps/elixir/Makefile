ELIXIR_GPG_KEY_URL := https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc

.PHONY: elixir-repos
elixir-repos:
	@$(MAKE) -s output-blue text="installing elixir repositories"
	@$(MAKE) -s apt-add-key url=$(ELIXIR_GPG_KEY_URL)
	@$(MAKE) -s apt-repo name="erlang" url="https://packages.erlang-solutions.com/ubuntu" codename="trusty" components="contrib"
	@$(MAKE) -s apt-update

.PHONY: elixir-build-deps
elixir-build-deps:
	@$(MAKE) -s output-blue text="installing elixir dependencies"
	@$(MAKE) -s apt-install packages="esl-erlang elixir=1.5.2-1 inotify-tools"

.PHONY: elixir-run-deps
elixir-run-deps:
	@$(MAKE) -s output-blue text="installing elixir dependencies"
	@$(MAKE) -s apt-install packages="esl-erlang"

.PHONY: elixir-setup
elixir-setup: elixir-install elixir-db-create

.PHONY: elixir-install
elixir-install:
	mix local.hex --force
	mix local.rebar --force
	mix deps.get
	mix compile

.PHONY: elixir-db-create
elixir-db-create:
	mix ecto.create

elixir-release:
	npm run-script deploy
	@for task in "compile" "phoenix.digest" "release"; do \
		MIX_ENV=prod mix "$$task"; \
	done

elixir-preserve-release:
	mkdir -p "/artifacts/elixir"
	cp -R /code/rel/* "/artifacts/elixir"
	mkdir -p "/artifacts/elixir/ag/releases/0.1.0/priv"
	cp -R "/code/apps/backend/priv/static" "/artifacts/elixir/ag/releases/0.1.0/priv"

elixir-install-release:
	mkdir -p "/app"
	cp -R /artifacts/elixir/* /app

.PHONY: elixir-start
elixir-start:
	if [ -d "apps/db/priv/repo/migrations" ]; then \
		mix ecto.migrate ;\
	fi
	mix run --no-halt

CURFILE := $(shell dirname $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
ifeq ($(CURFILE), $(CURDIR))
include ../shared/*.mk
endif
