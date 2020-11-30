# Flight Predictor BDFI 2020
Este proyecto se ha realizado por Javier Anton Yuste y David Recuenzo Bermejo como practica para la asignatura BDFI del año 2020 del Master Universitario en Ingenieria de Telecomunicacion. Esta basado en el proyecto facilitado por la misma asignatura que se puede encontrar en el siguiente repositorio: [https://github.com/ging/practica_big_data_2019](https://github.com/ging/practica_big_data_2019)

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

### Recursos
En la carpeta docker-compose de este repositorio se encuentran los recursos empleados para soportar a al aplicacion. Se pueden encontrar varias subcarpetas y archivos:

 - **flask**: en esta subcarpeta se encuentran diferentes ficheros, detallados a continuacion:
   - resources: carpeta donde se encuentran los difentes recursos necesarios para levantar la web
   - Dockerfile: fichero necesario para crear la imagen de Docker de flask.
   - requirements.txt: paquetes requeridos para el correcto funcionamiento de flask. Incluidos en el contenedor a traves del Dockerfile.

 - **cluster-base y spark-base**: en estas carpetas se encuentran los Dockerfiles de apoyo para la creacion de los contenedores de Spark.
 - **spark-master**: 
   - Dockerfile: fichero para la creacion de la imagen Docker
   - startup-master.sh: fichero empleado como entrypoint en la imagen.
- **spark-worker**
   - Dockerfile: igual que para el spark-master
   - startup-worker.sh: igual que el spark-master
   - flight_prediction_2.12-0.1.jar: fichero empleado por el job de spark-submit para poder ser capaz de realizar la prediccion de retraso de vuelos.
 - **docker-compose.yaml**: usado para levantar la aplicacion usando las imagenes realizadas, y ademas otras de DockerHub, las cuales son:
   - [zookeeper](https://hub.docker.com/r/wurstmeister/zookeeper)
   - [kafka](https://hub.docker.com/r/wurstmeister/kafka)
   - [mongo](https://hub.docker.com/_/mongo)
   - [mongo-seed](https://hub.docker.com/r/fvilers/mongo-seed)
Empleada para introducir automaticamente al iniciarse el docker-compose los datos a la base de datos de mongo.

Todas las imagenes creadas por nosotros han sido subidas a [nuestro repositorio de DockerHub](https://hub.docker.com/u/javianton97) empleando el siguiente procedimiento.

    # Construccion de la imagen, con su tag
    docker build . -t javianton97/<tag>
    
    #Subida a DockerHub
    docker push javianton97/<tag>
  
 Ahi se pueden encontrar las imagenes de [flask](https://hub.docker.com/r/javianton97/flask-compose), [flask para Google Cloud](https://hub.docker.com/r/javianton97/flask-compose-gc), [spark-master](https://hub.docker.com/r/javianton97/spark-master) y [spark-worker](https://hub.docker.com/r/javianton97/spark-worker) del docker-compose empleado.

### Inicializacion
Para iniciar docker-compose, se debe clonar el repositorio con:

    git clone git@github.com:JavierAntonYuste/BDFI2020.git
 
Navegar hasta la carpeta donde se encuentra el archivo docker-compose.yaml:

    cd docker-compose
    
Y, dependiendo de donde se quiera desplegar, si en local o en Google cloud se debe modificar las lineas correspondientes en el fichero docker-compose.yaml:

    web:
    # Descomentar para usar imagen para Google Cloud
    image: javianton97/flask-compose-gc
    # Descomentar para usar imagen para local
    # image: javianton97/flask-compose
  
  **Nota**: Por defecto esta para desplegarse en Google Cloud
  
  Una vez realizado este procedimiento, se puede proceder a ejecutar docker-compose con:
  

    docker-compose up
  
 **Nota**: Como se emplean todas las imagenes desde DockerHub no hace falta hacer docker-compose build, ya que estan todas las imagenes construidas, acelerando mucho el proceso de activacion de la aplicacion.

## kubernetes
