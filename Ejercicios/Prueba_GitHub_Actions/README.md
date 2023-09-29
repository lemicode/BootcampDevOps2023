# Ejercicio en GitHub Actions

Se construirá una imagen de Docker y luego se subirá al repositorio creado en la registry de DockerHub.

### 1. Se crea una Action, en este caso se selecciona _Docker image_.

<img src="./images/1.png">

### 2. Se crea el Workflow.

<img src="./images/2.png">

### 3. Se configuran las variables para el login, por lo cual deben ser de tipo _secret_.

<img src="./images/3.png">

### 4. Se ejecuta el Workflow.

<img src="./images/4.png">

### 5. Se verifica la ejecución del Workflow.

<img src="./images/5.png">

### 6. Se verifica la imagen en DockerHub.

<img src="./images/6.png">