# Flight Predictor BDFI 2020
Este proyecto se ha realizado por Javier Antón Yuste y David Recuenzo Bermejo como práctica para la asignatura BDFI del año 2020 del Máster Universitario en Ingeniería de Telecomunicación. Esta basado en el proyecto facilitado por la misma asignatura que se puede encontrar en el siguiente repositorio: [https://github.com/ging/practica_big_data_2019](https://github.com/ging/practica_big_data_2019)

La anterior aplicación se ha desplegado de tres formas diferentes, en local, usando la herramienta docker-compose para local y para Google Cloud Platform, y usando Kubernetes en Azure. Se detallan ambos procedimientos a continuación.

## Procedimiento local
Se ha seguido el procedimiento marcado en el [README.md](https://github.com/ging/practica_big_data_2019/blob/master/README.md) detallado en el repositorio referenciado, haciendo ajustes en las versiones de los diferentes componentes, ya que están desactualizados en la guía dada.

Las versiones usadas han sido las siguientes:
| Herramienta | Versión |
|--|--|
| Scala | 2.12 |
| Java JDK | 8 |
| Spark | 3.0.1 para Hadoop 2.7 |
| Kafka | 2.12-2.6.0 |
| Zookeeper | 3.6.2 |
| Mongo | 4.4 |

Además, se han actualizado también la versión de los componentes de Scala que aparecen en el [build.sbt](https://github.com/ging/practica_big_data_2019/blob/master/flight_prediction/build.sbt)  del repositorio:
| Conector | Version |
|--|--|
| sparkVersion | 3.0.1 |
| spark-sql-kafka | 0.10_2.12:3.0.1 |
| mongo-spark-connector| 2_12:3.0.0 |

Aparte de eso, se puede consultar el procedimiento seguido en el archivo procedimiento-local.txt subido en este mismo repositorio.

## docker-compose

### Recursos
En la carpeta docker-compose de este repositorio se encuentran los recursos empleados para soportar a al aplicación. Se pueden encontrar varias subcarpetas y archivos:

 - **flask**: en esta subcarpeta se encuentran diferentes ficheros, detallados a continuación:
   - resources: carpeta donde se encuentran los diferentes recursos necesarios para levantar la web.
   - Dockerfile: fichero necesario para crear la imagen de Docker de flask.
   - requirements.txt: paquetes requeridos para el correcto funcionamiento de flask. Incluidos en el contenedor a través del Dockerfile.

 - **cluster-base y spark-base**: aquí se encuentran los Dockerfiles de apoyo para la creación de los contenedores de Spark.
 - **spark-master**:
   - Dockerfile: fichero para la creación de la imagen Docker
   - startup-master.sh: fichero empleado como entrypoint en la imagen.
- **spark-worker**:
   - Dockerfile: igual que para el spark-master
   - startup-worker.sh: igual que el spark-master
   - flight_prediction_2.12-0.1.jar: fichero empleado por el job de spark-submit para poder ser capaz de realizar la predicción de retraso de vuelos.
 - **docker-compose.yaml**: usado para levantar la aplicación usando las imágenes realizadas, y además otras de DockerHub, las cuales son:
   - [zookeeper](https://hub.docker.com/r/wurstmeister/zookeeper)
   - [kafka](https://hub.docker.com/r/wurstmeister/kafka)
   - [mongo](https://hub.docker.com/_/mongo)
   - [mongo-seed](https://hub.docker.com/r/fvilers/mongo-seed)
Empleada para introducir automáticamente al iniciarse el docker-compose los datos a la base de datos de mongo.

Todas las imágenes creadas por nosotros han sido subidas a [nuestro repositorio de DockerHub](https://hub.docker.com/u/javianton97) empleando el siguiente procedimiento.

    # Construcción de la imagen, con su tag
    docker build . -t javianton97/<tag>

    #Subida a DockerHub
    docker push javianton97/<tag>

 Ahí se pueden encontrar las imágenes de [flask](https://hub.docker.com/r/javianton97/flask-compose), [flask para Google Cloud](https://hub.docker.com/r/javianton97/flask-compose-gc), [spark-master](https://hub.docker.com/r/javianton97/spark-master) y [spark-worker](https://hub.docker.com/r/javianton97/spark-worker) del docker-compose empleado.

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

 **Nota**: Como se emplean todas las imágenes desde DockerHub no hace falta hacer docker-compose build, ya que estan todas las imágenes construidas, acelerando mucho el proceso de activación de la aplicación.

## Kubernetes
Se ha realizado el despliegue de la aplicación en Kubernetes, concretamente en la plataforma de Microsoft Azure.

### Recursos
Para generar los archivos de despliegue se ha hecho uso de la herramienta [kompose](https://github.com/kubernetes/kompose), que nos ha ayudado a traducir nuestro docker-compose a Kubernetes.

En la carpeta kubernetes de este repositorio se pueden encontrar varias subcarpetas:

 - **k8s-images**: como en el procedimiento anterior  para docker-compose, se han tenido que crear varias imágenes propias para poder desplegar la aplicación. Los ficheros para la creación de estas imágenes se encuentran en esta carpeta.

- **old-deployments**: nos ha llevado tiempo familiarizarnos con k8s, para lo cual hemos tenido que experimentar con varias configuraciones y estos que se encuentran aquí son el resultado de viejos despliegues fallidos, que queríamos guardar como backup.

- **svc-deployments**: se encuentran, por carpetas los diferentes ficheros de despliegue, entre los que cabe destacar:
  - mongo-statefulset: despliegue con persistencia de la base de datos mongo, para lo cual se ha tenido que desplegar un volumen persistente, una clase de almacenamiento personalizada y el propio despliegue incluyendo la claim del volumen persistente.

  - mynet-networkpolicy.yaml: archivo donde se especifican las políticas de networking del cluster.

Al desplegarlo hemos tenido varios problemas con los nombres, ya que kubernetes tenia ciertos nombres reservados y no se podían usar, ya que incidían al error.

### Despliegue
Para poder desplegar los servicios en el cluster de k8s hay que tomar los pasos marcados a continuación.

Clonar el repositorio git en nuestro ordenador:

    git clone git@github.com:JavierAntonYuste/BDFI2020.git

Acceder a la carpeta donde se encuentran los ficheros de despliegue:

    cd kubernetes/svc-deployments/

(Opcional) Crear un namespace para desplegarlo en Kubernetes:

    kubectl create namespace <nombre>

Desplegar los diferentes servicios y despliegues de todos los elementos (excepto mongo) con la orden:

    # Creacion del servicio
    kubectl apply -f <nombre servicio>-service.yaml -n <nombre namespace>


    # Despliegue del elemento
    kubectl apply -f <nombre deployment>-deployment.yaml -n <nombre namespace>

Para poder desplegar el statefulset de mongo se deben introducir los siguientes comandos:

    # Creacion de la clase de almacenamiento
    kubectl apply -f storage-class.yaml

    # Creacion del volumen persistente
    kubectl apply -f persistenvolume.yaml -n <nombre namespace>

    # Despliegue de mongo y su servicio (juntos en el mismo archivo)
    kubectl apply -f mongo-deployment.yaml -n <nombre namespace>

Para poder popular la base de datos de mongo, necesitamos hacer un import de los datos, realizándolo de la siguiente manera:

    # Averiguamos el nombre del pod de mongo:
    kubectl get pods -n <nombre namespace>

    # Entramos en el pod de mongo
    kubectl exec -it <nombre pod> /bin/bash -n <nombre namespace>

    # Ejecutamos la orden de mongoimport
    mongoimport -d agile_data_science -c origin_dest_distances --file /home/origin_dest_distances.jsonl

Una vez realizados estos pasos, se puede probar que el cluster funciona mediante un port-forward del servicio web a nuestro PC, conseguido mediante la siguiente orden:

    kubectl port-forward svc/web 5000:5000 -n <nombre namespace>

Con esto, podemos ir a un navegador a la dirección ``localhost:5000``, donde encontramos nuestra web, y si vamos concretamente a la ruta ``localhost:5000/flights/delays/predict_kafka`` donde encontramos el predictor de vuelos.
