#!/bin/bash

## Escribir comando de spark-submit hecho
"$SPARK_HOME/bin/spark-submit"
      --conf "spark.driver.bindAddress=$SPARK_DRIVER_BIND_ADDRESS"
      --deploy-mode client

spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master local # Cambiar por master k8s
 --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.0,org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.1
/home/flight_prediction_2.12-0.1.jar
