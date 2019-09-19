FROM ubuntu:16.04

RUN apt-get update -qq && \
    apt-get upgrade -qq -y && \
    apt-get install -qq -y \
            build-essential \
            autoconf \
            libncurses5-dev \
            libssh-dev \
            libxml2-utils \
            unixodbc-dev \
            git \
            curl \
            unzip \
            xsltproc \
            fop \
            inotify-tools && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

ENV LANG C.UTF-8

RUN useradd -ms $(which bash) asdf

ENV PATH /home/asdf/.asdf/bin:/home/asdf/.asdf/shims:$PATH

USER asdf

# asdf, erlang

RUN /bin/bash -c "git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.4 && \
                  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
                  asdf install erlang 22.0 && \
                  asdf global erlang 22.0"

# elixir

RUN /bin/bash -c "asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \
                  asdf install elixir 1.9.1 && \
                  asdf global elixir 1.9.1"


# nodejs, yarn

RUN /bin/bash -c "asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
                  ~/.asdf/plugins/nodejs/bin/import-release-team-keyring && \
                  asdf install nodejs 10.16.3 && \
                  asdf global nodejs 10.16.3 && \
                  npm install -g yarn"