FROM ubuntu:14.04
ENV DEBIAN_FRONTEND=noninteractive
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

RUN apt-get update -qq && apt-get install -y build-essential

COPY makedeps/shared /code/makedeps/shared

COPY makedeps/base-build /code/makedeps/base-build
RUN cd /code/makedeps/base-build && make base-repos base-build-deps

COPY makedeps/postgres /code/makedeps/postgres
RUN cd /code/makedeps/postgres && make postgres-repos postgres-build-deps

COPY makedeps/node /code/makedeps/node
RUN cd /code/makedeps/node && make node-repos node-build-deps

COPY makedeps/elixir /code/makedeps/elixir
RUN cd /code/makedeps/elixir && make elixir-repos elixir-build-deps

RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

COPY . /code
WORKDIR /code

COPY mix.exs mix.lock /code/
CMD make elixir-setup && make node-setup && /bin/bash
