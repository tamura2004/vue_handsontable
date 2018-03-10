FROM ruby:2.4

RUN apt-get update -qq && apt-get install -y \
	build-essential \
	libpq-dev \
	nodejs

ENV APP /vue_handsontable

RUN mkdir $APP
WORKDIR $APP

ADD Gemfile ${APP}/Gemfile
ADD Gemfile.lock ${APP}/Gemfile.lock
RUN bundle

ADD . $APP



