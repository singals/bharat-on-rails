FROM ruby:3.0.3-alpine3.15

RUN #apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /bharat

WORKDIR /bharat

COPY . /bharat

RUN bundle install