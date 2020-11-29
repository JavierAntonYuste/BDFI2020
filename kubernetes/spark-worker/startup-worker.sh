#!/bin/bash

/usr/bin/spark-3.0.1-bin-hadoop2.7/bin/spark-submit \
  --class es.upm.dit.ging.predictor.MakePrediction \
  --master spark://spark-hdfs:7077 \
  --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.0,org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.1 \
  /flight_prediction_2.12-0.1.jar
