FROM ruby:2.4.0-slim

ENV APP_HOME /url_shortener
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update -qq
RUN apt-get install -qq -y git curl wget build-essential libpq-dev apt-transport-https \
    postgresql-client ntp --no-install-recommends --fix-missing
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -qq -y nodejs yarn

ADD package.json ./
ADD yarn.lock ./
RUN yarn install

ENV BUNDLE_PATH /bundle
ADD Gemfile* ./
RUN bundle install

ADD . .

RUN ruby bin/webpack

CMD puma -C config/puma.rb
