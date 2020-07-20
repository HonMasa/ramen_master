FROM ruby:2.6.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim
                       
                       
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y yarn

RUN mkdir /ramen_master

WORKDIR /ramen_master

ADD Gemfile /ramen_master/Gemfile
ADD Gemfile.lock /ramen_master/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /ramen_master

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids