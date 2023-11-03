# Docker y Kubernetes - Desafío 8

## Parte 1

### Entregables

1. El entregable de esta práctica será un repo con el código del Dockerfile y el link a la imagen de DockerHub. Así mismo, cualquier otro tipo de archivo secundario para la correcta construcción de la imagen será necesario que lo suban.
2. Desarrollar un pipeline de CI/CD en GitHubAction que realice el build de la imagen y lo publique a DockerHub.

### Requisitos mínimos

:white_check_mark: Algún archivo que sea agregado de forma externa con la opción de utilizar un volumen para almacenarlo.  
:white_check_mark: Algún servicio que se pueda acceder de forma remota (como puede ser una base de datos, un servicio web, etc).  
:white_check_mark: Se tendrá que poder acceder desde la máquina host donde se ejecute ese contenedor.  
:white_check_mark: El tag que utilice la imagen tendrá que seguir algún esquema de versionado y no el tag latest.  

### Solución Parte 1 - Entregable No. 1

#### Pasos para implementar la solución **sin** Docker Compose

1. Crear una red para que los contenedores se puedan comunicar, para ello hay que ejecutar `docker network create my_network`.

2. Se valida la creación de la red con `docker network ls`. En el caso de querer eliminarla se ejecuta `docker network rm my_network`.

3. Ejecutar `docker pull mongo` para descargar la imagen de MongoDB.

4. Ejecutar `docker create -p 27017:27017 --name mongo-service --network my_network -e MONGO_INITDB_ROOT_USERNAME=my_user -e MONGO_INITDB_ROOT_PASSWORD=my_password mongo` para crear el contenedor que contendrá la base de datos.

5. Ejecutar `docker start mongo-service` para iniciar el contenedor de MongoDB.

6. Se construye la imagen con `docker build -t orpimel/desafio_8:v1.0.0 .`.

7. Se crea un directorio en el host anfitrión con `mkdir $HOME/Desktop/host_volume`.

8. Ejecutar `docker create -p 3000:3000 --name myapp --network my_network -v $HOME/Desktop/host_volume:/home/app/volume orpimel/desafio_8:v1.0.0`.

9. Ejecutar `docker start myapp` para iniciar el contenedor de la app. 

10. Para crear registros en la base de datos de manera automática, se ingresa a la ruta http://localhost:3000/crear, luego se valida el listado en http://localhost:3000.

11. Por último, se valida el funcionamiento del volumen mediante la creación de cualquier archivo en el host anfitrión en la ruta _$HOME/Desktop/host_volume_, luego se verifica que el archivo se encuentre en el contenedor de nombre _myapp_ en la ruta /home/app/volume.

    - Comando para acceder al contenedor: `docker exec -it myapp bash`.

__Nota:__ En el caso de tener inconvenientes donde el sistema mencione algo relacionado con las credenciales, se puede solucionar ejecutando `rm ~/.docker/config.json` para eliminar el archivo config.json, y luego se vuelve a iniciar sesión con `docker login`. Por otra parte, también es posible validar que todo marcha bien con la app antes de construir la imagen de Docker mediante la ejecución en local del comando `node index.js` (index.js se encuentra ubicado en el directorio *docker_image*) posterior a la instalación de las dependencias `npm install`.

#### Pasos para implementar la solución __con__ Docker Compose

1. Ejecutar `docker compose up -d` para crear los contenedores y dejarlos en ejecución en segundo plano.

2. Para crear registros en la base de datos de manera automática, se ingresa a la ruta http://localhost:3000/crear, luego se valida el listado en http://localhost:3000.

3. Por último, se valida el funcionamiento del volumen mediante la creación de cualquier archivo en el host anfitrión en la ruta _$HOME/Desktop/host_volume_, luego se verifica que el archivo se encuentre en el contenedor de nombre _myapp_ en la ruta /home/app/volume.

4. Para deshacer la creación de los *contenedores*, se ejecuta `docker compose down`.

**Algunos comandos que podrían resultar útiles:**

- Listar volúmenes: `docker volume ls`.
- Eliminar volúmenes: `docker volume rm <nombre del volumen>`.
- Eliminar volúmenes no utilizados: `docker volume prune`.
- Ver logs de un contenedor: `docker logs <nombre del contenedor>`.
- Listar contenedores: `docker ps -a`.
- Eliminar una imagen: `docker rmi <nombre de la imagen>`.
- Eliminar un contenedor: `docker rm <nombre del contenedor>`.
- Listar redes: `docker network ls`.

__Nota:__ el archivo docker-compose.yml se encuentra ubicado en el directorio *docker_image*.

### Solución Parte 1 - Entregable No. 2

1. El pipeline se encuentra en [../.github/workflows/docker-image-desafio-8.yml](../.github/workflows/docker-image-desafio-8.yml)
2. La imagen construida y subida mediante GitHub Actions se encuentra en [orpimel/desafio_8:v1.0.0](https://hub.docker.com/repository/docker/orpimel/desafio_8)
    - Comando para descarga directa de la imagen: `docker pull orpimel/desafio_8:v1.0.0`.

## Parte 2

### Entregables

1. Instructivo con los pasos seguidos para la creación del cluster de Kubernetes.
2. Archivos .yaml utilizados para levantar correctamente la aplicación.

### Requisitos mínimos

:white_check_mark: Tendrá que ser un deployment si o si (no pod, no replica set).  
:white_check_mark: Tendrá que tener algún tipo de volumen o secreto configurado.  
:white_check_mark: Tendrá que ser expuesto fuera del cluster (ClusterIP).  
:white_check_mark: Tendrá que tener entre 3 y 5 réplicas idealmente.  
:white_check_mark: Tendrá que tener un método de rollback configurado distinto al default.  

### Solución Parte 2 - Entregables No. 1 y No. 2

1. Una vez instalado Minikube, se procede con su ejecución `minikube start` (en esta parte se crearía un clúster por defecto). Es importante destacar, que primero se inicia Docker con `systemctl --user start docker-desktop`.

2. Luego se valida el funcionamiento de las herramientas:
    - `systemctl --user status docker-desktop`
    - `kubectl version`
    - `minikube version`

3. Se aplican los manifiestos de Kubernetes ubicados en [./minikube](./minikube/).

4. Una vez se creen los recursos **y se estabilicen**, se ejecuta `minikube tunnel` para poder acceder a la aplicación desde el navegador.

5. Finalmente, en un navegador del host anfitrión se valida el funcionamiento de los pods mediante el ingreso a la ruta http://localhost:3000 para listar los registros y http://localhost:3000/crear para generar nuevos registros en la BD.

 **Otros comandos que podrían resultar útiles:**

- Si se requiere eliminar algún recurso se ejecutaría:
    - `kubectl delete -f ./minikube` (para eliminar todos los recursos).
    - `kubectl delete -f ./minikube/<archivo.yaml>` (para eliminar un recurso en específico mediante YAML).
    - `kubectl delete <tipo de objeto> <nombre de objeto>` (para eliminar un recurso en específico).
- En el caso que se requiera abordar de manera general la explicación de alguna propiedad contenida en los manifiestos, se puede consultar mediante el comando `kubectl explain <propiedad>`, por ejemplo `kubectl explain service.metadata.name`.
- Para validar el estado de los recursos se ejecuta `kubectl get all`.
- Para validar el estado de los recursos se ejecuta `kubectl get <tipo de recurso> -o wide` (*-o wide* se emplea para ampliar la información que ofrece por defecto kubectl o *-o yaml* para obtener la información en formato YAML).
- Para observar en tiempo real el estado de los pods se ejecuta `kubectl get pod --watch`.
- Para obtener logs de un pod se ejecuta `kubectl logs <nombre del pod>`.
- Para obtener la descripción de algún recurso se ejecuta `kubectl describe <tipo de recurso> <nombre del recurso>`.
- Con `minikube stop` se detiene Minikube .
- Con `minikube delete` se elimina todo lo realizado por MiniKube.
- Para ingresar a un pod se ejecuta `kubectl exec -it <nombre del pod> -- bash` (con más de un contenedor sería `kubectl exec -it <nombre del pod> -c <nombre del contenedor> -- bash`).
- Para observar los eventos de Kubernetes se ejecuta `kubectl get events` (agregar *--watch* para observar en tiempo real).

## Presentación PDF donde se evidencia la puesta en práctica y el funcionamiento de los ejercicios.

[Solución Desafio 8 - Marco Vanegas.pdf](Solución_Desafio_8_-_Marco_Vanegas.pdf).