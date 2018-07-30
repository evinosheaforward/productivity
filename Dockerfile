FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /productivity
WORKDIR /productivity
VOLUME /var/lib/postgresql/
COPY Gemfile /productivity/Gemfile
COPY Gemfile.lock /productivity/Gemfile.lock
RUN bundle install
ADD . /productivity
