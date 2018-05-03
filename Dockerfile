FROM ruby:2.5.0

ENV RAILS_ENV "production"
ENV RAILS_SERVE_STATIC_FILES 1
ENV NODE_VERSION "8.9.4"
ENV NODE_ENV "production"

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE $SECRET_KEY_BASE

RUN apt-get update -qq && \
  apt-get install -y \
    build-essential apt-transport-https apt-utils locales \
    git screen vim rsync \
    libxml2-dev libxslt1-dev

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install --without development test

ADD package.json $APP_HOME/
# ADD yarn.lock $APP_HOME/
RUN yarn install

COPY config/puma.rb config/puma.rb

ADD . $APP_HOME

RUN bin/rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]


