
FROM fluent/fluentd:latest
MAINTAINER Stéphie <stephanie.chhim@onepark.fr>

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
  && sudo gem install \fluent-plugin-s3 \
  && sudo gem install \fluent-plugin-webhdfs \

  && sudo gem sources --clear-all \
   && apk del .build-deps \
   && rm -rf /var/cache/apk/* \
             /home/fluent/.gem/ruby/2.3.0/cache/*.gem

EXPOSE 24284

# Set up Fluent configuration file
CMD fluentd --setup /etc/fluent
CMD vi conf/fluent.conf

# Start an instance of Fluentd
CMD fluentd -s conf
CMD fluentd -c conf/fluent.conf
