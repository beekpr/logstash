FROM logstash:2.3.2-1

RUN apt-get update && apt-get install -y --no-install-recommends python2.7 \
    && rm -rf /var/lib/apt/lists/*
RUN plugin install logstash-output-amazon_es

ADD config /etc/logstash/config.template
ADD render_config.py /usr/local/bin/render_config
ADD docker-render-entrypoint.sh /docker-render-entrypoint.sh

ENV \
  LS_HEAP_SIZE="512m"

ENTRYPOINT ["/docker-render-entrypoint.sh"]
CMD logstash -f /etc/logstash/config
