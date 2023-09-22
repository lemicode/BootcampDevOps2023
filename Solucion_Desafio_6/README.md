# Aprovisionamiento de un balanceador de carga que permita la distribución de tráfico entre dos instancias EC2

## Objetivos

1. Crear una VPC con dos subredes privadas y dos subredes públicas.
2. Es necesario crear dos instancias EC2, dichas instancias deben estar en dos zonas de disponibilidad distintas.
3. Cada instancia debe poseer instalado un servidor web que muestre el nombre de la instancia y la región en la que se encuentra.
4. Agregar estas instancias a un target group.
5. Crear el balanceador de carga y agregar el target group al balanceador.

## Pasos para el aprovisionamiento

1. Ejecutar `terraform init` para inicializar el directorio con Terraform.
2. Ejecutar `terraform plan --out terraform.plan` para ver los recursos que se crearán.
3. Ejecutar `terraform apply` para aplicar los cambios y aprovisionar la infraestructura.

## Output del `terraform plan`

[terraform.plan](terraform.plan).

## PDF donde se documenta el proceso de aprovisionamiento

[Solución Desafio 6 - Marco Vanegas.pdf](Solución_Desafio_6_-_Marco_Vanegas.pdf).
