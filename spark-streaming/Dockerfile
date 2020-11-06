FROM debian:stretch

# Environment
ENV SPARK_VERSION 3.0.1
ENV HADOOP_VERSION 2.7
ENV SCALA_VERSION 2.12
ENV SPARK_HOME /usr/local/spark
ENV SBT_VERSION 1.4.2

RUN apt-get -y update && apt-get install -y wget && apt-get install -y --no-install-recommends openjdk-8-jdk && apt-get install -y git

# Spark
RUN cd /tmp && \
    wget https://apache.brunneis.com/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN cd /usr/local && ln -s spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

# Spark Kafka Streaming
RUN cd /tmp && \
    wget https://repo.maven.apache.org/maven2/org/apache/spark/spark-streaming-kafka-0-10-assembly_${SCALA_VERSION}/${SPARK_VERSION}/spark-streaming-kafka-0-10-assembly_${SCALA_VERSION}-${SPARK_VERSION}.jar && \
    mv spark-streaming-kafka-0-10-assembly_${SCALA_VERSION}-${SPARK_VERSION}.jar /usr/local/spark/jars

#SBT
RUN apt-get update && apt-get install -y gnupg2 && apt-get install -y curl && \
    curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
    dpkg -i sbt-$SBT_VERSION.deb && \
    rm sbt-$SBT_VERSION.deb && \
    apt-get update && \
    apt-get install sbt


#Clone repository
RUN cd /home/ && git clone https://github.com/ging/practica_big_data_2019.git 

EXPOSE 8080
EXPOSE 6066
EXPOSE 7077
