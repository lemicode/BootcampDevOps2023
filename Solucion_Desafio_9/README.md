# Argo CD - Desafío 9

### Entregables

1. El entregable de esta práctica será un repo con el código del Dockerfile y el link a la imagen de DockerHub. Así mismo, cualquier otro tipo de archivo secundario para la correcta construcción de la imagen será necesario que lo suban.

### Requisitos mínimos

:white_check_mark: Algún archivo que sea agregado de forma externa con la opción de utilizar un volumen para almacenarlo. 

### Solución Parte 1 - Entregable No. 1

#### Pasos para implementar la solución **sin** Docker Compose

1. Crear una red para que los contenedores se puedan comunicar, para ello hay que ejecutar `docker network create my_network`.

**Otros comandos:**

- Listar volúmenes: `docker volume ls`.