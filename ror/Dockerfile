FROM ruby:2.7.6-alpine3.16

WORKDIR /usr/src/app

RUN apk update && \
    apk add --no-cache \
    build-base mysql-client tzdata mysql-dev sqlite-dev


COPY ./Gemfile .
COPY ./Gemfile.lock .

RUN bundle config --local without "development"
RUN bundle install 

COPY . .

RUN rm -f ./tmp/pids/server.pid

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]