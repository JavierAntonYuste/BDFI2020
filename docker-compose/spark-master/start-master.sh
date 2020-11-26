#!/bin/bash

export SPARK_MASTER_HOST=`hostname`

. "bin/spark-config.sh"

. "bin/load-spark-env.sh"

mkdir -p $SPARK_MASTER_LOG

ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out
