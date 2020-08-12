FROM ruby:2.7.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  nodejs \
  postgresql-client \
  yarn && \
  rm -rf /var/lib/apt/lists/*

ENV APP /moneta3

RUN mkdir $APP
WORKDIR $APP
COPY Gemfile $APP/Gemfile
COPY Gemfile.lock $APP/Gemfile.lock

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES "YES"
RUN bundle install
COPY . $APP

RUN yarn

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]