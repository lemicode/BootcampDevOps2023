# Prueba de LocalStack

## Descripción

1. Se instala Docker y LocalStack en el equipo local.
2. Se inicializa Docker (`systemctl --user start docker-desktop`) para levantar los servicios de LocalStack.

![1][https://raw.githubusercontent.com/BambooThink/BootcampDevOps2023/main/Ejercicios/Prueba_LocalStack/images/1.png]

3. Se inicializa LocalStack `localstackt start`.

![2][https://raw.githubusercontent.com/BambooThink/BootcampDevOps2023/main/Ejercicios/Prueba_LocalStack/images/2.png]

4. Se ejecuta `terraform init`.

![3][https://raw.githubusercontent.com/BambooThink/BootcampDevOps2023/main/Ejercicios/Prueba_LocalStack/images/3.png]

5. Se ejecuta `terraform apply`.

![4][https://raw.githubusercontent.com/BambooThink/BootcampDevOps2023/main/Ejercicios/Prueba_LocalStack/images/4.png]