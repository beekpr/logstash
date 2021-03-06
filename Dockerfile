FROM docker.elastic.co/logstash/logstash:5.6.5

RUN logstash-plugin install logstash-output-amazon_es

ENV \
  LS_HEAP_SIZE="128m" \
  XPACK_MONITORING_ENABLED=false
EXPOSE 12201/udp
EXPOSE 12202/udp
EXPOSE 5140/udp

