FROM ruby:2.3.1-alpine

MAINTAINER Yasuaki Uechi <uetchy@randompaper.co>

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev sqlite-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs" \
    RAILS_VERSION="5.0.0"

RUN apk update && apk upgrade && apk --update --upgrade add $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

WORKDIR /app
COPY . /app
EXPOSE 3000
RUN gem install -N nokogiri rails && \
    bundle install -j4 && \
    bundle clean

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
