FROM ruby:2.4

RUN apt-get update -qq && \
	apt-get install -y --no-install-recommends \
		build-essential \
		libpq-dev \
		npm \
		nodejs && \
		rm -rf /var/lib/apt/lists/*

ENV APP /app

RUN mkdir -p $APP
WORKDIR $APP
ADD Gemfile $APP/
ADD Gemfile.lock $APP/

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES "YES"
RUN bundle install

ADD . $APP
RUN mkdir -p /root/run/
RUN touch /root/run/app.pid