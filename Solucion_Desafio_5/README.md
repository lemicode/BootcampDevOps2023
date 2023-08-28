# Aprovisionamiento de Máquina Virtual Windows en AWS con Terraform

Este repositorio contiene la configuración de Terraform para provisionar una instancia EC2 con Windows en AWS.

## Pasos para el aprovisionamiento

1. Ejecutar `terraform init` para inicializar el directorio con Terraform.
2. Ejecutar `terraform plan --out instance.plan` para ver los recursos que se crearán.
3. Ejecutar `terraform apply` para aplicar los cambios y provisionar la infraestructura.

## Output del `terraform plan`

[instance.plan](instance.plan).

## PDF donde se documenta el proceso de aprovisionamiento de una máquina virtual Windows en AWS

[Solución Desafio 5 - Marco Vanegas.pdf](Solución_Desafio_5_-_Marco_Vanegas.pdf).
