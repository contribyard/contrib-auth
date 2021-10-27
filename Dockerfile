FROM ruby:3.0.2

WORKDIR /var/gem

COPY . .

RUN gem install bundler
RUN bundle install
