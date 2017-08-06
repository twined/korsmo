# Korsmo

Build and update hub image:

    $ docker build -t twined/korsmo:1.0 .
    $ docker push twined/korsmo:1.0

### Example Dockerfile

```
FROM twined/korsmo:1.0

MAINTAINER Twined Networks <mail@twined.net>

COPY . /opt/app
WORKDIR /opt/app

ENV MIX_ENV prod

RUN mix clean
RUN mix deps.clean --all
RUN mix deps.get
RUN mix deps.compile

COPY package.json yarn.lock /opt/app/assets
RUN cd assets/ && yarn --pure-lockfile
RUN cd assets/ && node_modules/.bin/brunch build -p

RUN mix phx.digest
RUN mix compile
RUN mix release --verbosity=verbose

```
