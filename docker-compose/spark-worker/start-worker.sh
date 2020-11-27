#!/bin/bash

# . "bin/spark-config.sh"
# . "bin/load-spark-env.sh"

# mkdir -p $SPARK_WORKER_LOG
#
# ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker.out
#
# /usr/bin/spark-3.0.1-bin-hadoop2.7/bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG/spark-worker.out

/usr/bin/spark-3.0.1-bin-hadoop2.7/bin/spark-submit \
  --class es.upm.dit.ging.predictor.MakePrediction \
  --master spark://spark-master:7077 \
  --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.0,org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.1 \
  /flight_prediction_2.12-0.1.jar
