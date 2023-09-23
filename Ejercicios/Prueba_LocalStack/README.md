# Prueba de LocalStack

## Descripción

1. Se instala Docker y LocalStack en el equipo local.
2. Se inicializa Docker (`systemctl --user start docker-desktop`) para levantar los servicios de LocalStack.

<img src="./images/1.png">

3. Se inicializa LocalStack `localstackt start`.

<img src="./images/2.png">

4. Se ejecuta `terraform init`.

<img src="./images/3.png">

5. Se ejecuta `terraform apply`.

<img src="./images/4.png">