FROM centos:centos7

MAINTAINER Twined Networks <mail@twined.net>

ENV ERLANG_VERSION 20.0-1
ENV ELIXIR_VERSION 1.5.1

# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN yum -y install --setopt=tsflags=nodocs epel-release wget unzip uuid less bzip2 git-core inotify-tools && \
    yum -y install https://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_1_general/esl-erlang_${ERLANG_VERSION}~centos~7_amd64.rpm \
    yum -y install esl-erlang-${ERLANG_VERSION} && \
    yum -y update && \
    yum -y reinstall glibc-common glibc

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum -y install nodejs
RUN yum clean all

RUN cd /tmp && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    unzip -d /usr/local/elixir -x Precompiled.zip && \
    rm -f /tmp/Precompiled.zip

ENV PATH ./node_modules/.bin:$PATH:/usr/local/elixir/bin
ENV HOME /opt/app

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

RUN npm install yarn -g --no-progress

WORKDIR /opt/app
