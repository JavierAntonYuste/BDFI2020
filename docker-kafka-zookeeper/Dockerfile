FROM alpine:3.9.2

RUN apk add --update openjdk8-jre supervisor bash

ENV ZOOKEEPER_VERSION 3.6.2
ENV ZOOKEEPER_HOME /opt/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.6.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
ENV KAFKA_DOWNLOAD_URL https://downloads.apache.org/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

# Zookeeper
RUN wget -q https://apache.brunneis.com/zookeeper/zookeeper-"$ZOOKEEPER_VERSION"/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz -O /tmp/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz && \
    tar xfz /tmp/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz -C /opt && rm /tmp/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz
ADD assets/conf/zoo.cfg $ZOOKEEPER_HOME/conf

# Kafka
RUN wget -q https://downloads.apache.org/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz 

ADD assets/scripts/start-kafka.sh /usr/bin/start-kafka.sh
ADD assets/scripts/start-zookeeper.sh /usr/bin/start-zookeeper.sh

# Supervisor config
ADD assets/supervisor/kafka.ini assets/supervisor/zookeeper.ini /etc/supervisor.d/

# 2181 is zookeeper, 9092 is kafka
EXPOSE 2181 9092

CMD ["supervisord", "-n"]
