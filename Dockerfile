FROM ruby

RUN apt-get update && apt-get -y install build-essential nodejs

RUN mkdir -p /app
WORKDIR /app

COPY ./bugApp/Gemfile ./bugApp/Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY bugApp ./

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
