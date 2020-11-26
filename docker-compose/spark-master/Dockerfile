FROM javianton97/spark-base

COPY start-master.sh /

ARG spark_master_web_ui=8080

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080

ENV SPARK_MASTER_LOG /usr/bin/spark-3.0.1-bin-hadoop2.7/logs

EXPOSE 8080 7077 6066

CMD ["/bin/bash", "/start-master.sh"]
