FROM javianton97/spark-base

COPY startup-master.sh /

ARG spark_master_web_ui=8080

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080

EXPOSE 8080 7077 6066

CMD ["/bin/bash", "/startup-master.sh"]
