FROM ruby:3.2.1-alpine

RUN apk update && apk add --no-cache build-base nodejs postgresql-dev tzdata

RUN mkdir /app
WORKDIR /app
COPY web .

COPY web/Gemfile web/Gemfile.lock ./
RUN gem install bundler --no-document
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3
RUN bundle install
RUN rails db:create
RUN rails db:migrate
RUN bundle exec rails assets:precompile


CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
