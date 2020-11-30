# Flight Predictor BDFI 2020
Este proyecto se ha realizado como practica para la asignatura BDFI del año 2020 del Master Universitario en Ingenieria de Telecomunicacion. Esta basado en el proyecto facilitado por la misma asignatura que se puede encontrar en el siguiente repositorio: [https://github.com/ging/practica_big_data_2019](https://github.com/ging/practica_big_data_2019)

La anterior aplicacion se ha desplegado de tres formas diferentes, en local, usando la herramienta docker-compose para local y para Google Cloud Platform, y usando Kubernetes en Azure. Se detallan ambos procedimientos a continuacion.

## Procedimiento local
Se ha seguido el procedimiento marcado en el [README.md](https://github.com/ging/practica_big_data_2019/blob/master/README.md) detallado en el repositorio referenciado, haciendo ajustes en las versiones de los diferentes componentes, ya que estan desactualizados en la guia dada.

Las versiones usadas han sido las siguientes:
| Herramienta | Version |
|--|--|
| Scala | 2.12 |
| Spark | 3.0.1 para Hadoop 2.7 |
| Kafka |  |
| Zookeeper |  |
| Mongo |  |

Ademas, se han actualizado tambien la version de los componentes de Scala que aparecen en el [build.sbt](https://github.com/ging/practica_big_data_2019/blob/master/flight_prediction/build.sbt)  del repositorio:
| Conector | Version |
|--|--|
| sparkVersion | 3.0.1 |
| spark-sql-kafka-0-10 | 3.0.1|
| mongo-spark-connector|  3.0.0|

Aparte de eso, se puede consultar el procedimiento seguido en el archivo ProcedimientoLocal.txt subido en este mismo repositorio.

## docker-compose
Se pueden encontrar los diferentes archivos empleados

## kubernetes
