# Docker y Kubernetes - Desafío 8

## Parte 1

### Entregables

1. El entregable de esta práctica será un repo con el código del Dockerfile y el link a la imagen de DockerHub. Así mismo, cualquier otro tipo de archivo secundario para la correcta construcción de la imagen será necesario que lo suban.
2. Desarrollar un pipeline de CI/CD en GitHubAction que realice el build de la imagen y lo publique a DockerHub.

### Requisitos mínimos

- Algún archivo que sea agregado de forma externa con la opción de utilizar un volumen para almacenarlo.
- Algún servicio que se pueda acceder de forma remota (como puede ser una base de datos, un servicio web, etc).
- Se tendrá que poder acceder desde la máquina host donde se ejecute ese contenedor.
- El tag que utilice la imagen tendrá que seguir algún esquema de versionado y no el tag latest.

### Solución Parte 1 - Entregable No. 1

#### Pasos para implementar la solución **sin** Docker Compose

1. Crear una red para que los contenedores se puedan comunicar, para ello hay que ejecutar `docker network create my_network`.

2. Se valida la creación de la red con `docker network ls`. En el caso de querer eliminarla se ejecuta `docker network rm my_network`.

3. Ejecutar `docker pull mongo` para descargar la imagen de MongoDB.

4. Ejecutar `docker create -p 27017:27017 --name my_mongo --network my_network -e MONGO_INITDB_ROOT_USERNAME=my_user -e MONGO_INITDB_ROOT_PASSWORD=my_password mongo` para crear el contenedor que contendrá la base de datos.

5. Ejecutar `docker start my_mongo` para iniciar el contenedor de MongoDB.

6. Se construye la imagen con `docker build -t orpimel/desafio_8:v1.0.0 .`.

7. Se crea un directorio en el host anfitrión con `mkdir $HOME/Desktop/host_volume`.

8. Ejecutar `docker create -p 3000:3000 --name my_app --network my_network -v $HOME/Desktop/host_volume:/home/app/volume orpimel/desafio_8:v1.0.0`.

9. Ejecutar `docker start my_app` para iniciar el contenedor de la app. 

10. Para crear registros en la base de datos de manera automática, se ingresa a la ruta http://localhost:3000/crear, luego se valida el listado en http://localhost:3000.

11. Por último, se valida el funcionamiento del volumen mediante la creación de cualquier archivo en el host anfitrión en la ruta _$HOME/Desktop/host_volume_, luego se verifica que el archivo se encuentre en el contenedor de nombre _my_app_ en la ruta /home/app/volume.

    - Comando para acceder al contenedor: `docker exec -it my_app bash`.

__Nota:__ En el caso de tener inconvenientes donde el sistema mencione algo relacionado con las credenciales, se puede solucionar ejecutando `rm ~/.docker/config.json` para eliminar el archivo config.json, y luego se vuelve a iniciar sesión con `docker login`. Por otra parte, también es posible validar que todo marcha bien con la app antes de construir la imagen de Docker mediante la ejecución en local del comando `node index.js` (index.js se encuentra ubicado en el directorio *docker_image*) posterior a la instalación de las dependencias `npm install`.

#### Pasos para implementar la solución __con__ Docker Compose

1. Ejecutar `docker compose up -d` para crear los contenedores y dejarlos en ejecución en segundo plano.

2. Para crear registros en la base de datos de manera automática, se ingresa a la ruta http://localhost:3000/crear, luego se valida el listado en http://localhost:3000.

3. Por último, se valida el funcionamiento del volumen mediante la creación de cualquier archivo en el host anfitrión en la ruta _$HOME/Desktop/host_volume_, luego se verifica que el archivo se encuentre en el contenedor de nombre _my_app_ en la ruta /home/app/volume.

4. Para deshacer la creación de los *contenedores*, se ejecuta `docker compose down`.

__Nota:__ el archivo docker-compose.yml se encuentra ubicado en el directorio *docker_image*.

## Solución Parte 1 - Entregable No. 2

1. El pipeline se encuentra en [../.github/workflows/docker-image-desafio-8.yml](../.github/workflows/docker-image-desafio-8.yml)
2. La imagen construida y subida mediante GitHub Actions se encuentra en [orpimel/desafio_8:v1.0.0](https://hub.docker.com/repository/docker/orpimel/desafio_8)