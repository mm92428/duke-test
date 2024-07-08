FROM bitnami/ruby:3.3.1

ARG SECRET_KEY_BASE=1

ENV APP_PATH=/opt/app-root/src
ENV HOME=/opt/app-root

RUN apt-get update -qq && apt-get upgrade -y && apt-get install -y --no-install-recommends libz-dev time tzdata sqlite3 libsqlite3-dev \
    && ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime 

WORKDIR ${APP_PATH}

COPY . ${APP_PATH}
RUN bundle install --retry 3 \
    && rm -rf `gem env gemdir`/cache/*.gem \
    && find `gem env gemdir`/gems/ -name "*.c" -delete \
    && find `gem env gemdir`/gems/ -name "*.o" -delete

RUN chgrp -R root $(gem env gemdir) /opt/bitnami/ruby && \
    chmod -R g=rwX /opt/app-root $(gem env gemdir) /opt/bitnami/ruby
