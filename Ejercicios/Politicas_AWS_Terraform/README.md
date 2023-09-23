# Aprovisionamiento de un usuario con permisos limitados para EC2 en AWS con Terraform

El propósito del presente ejercicio es crear un usuario IAM que pueda realizar todas las acciones en las instancias EC2 que existan, excepto terminarlas o eliminarlas.

## Nota

Se creó una estructura estándar para los ficheros de Terraform. No obstantes, algunos archivos se encuentran vacíos ya que sólo fueron creados con fines demostrativos.

## Pasos para el aprovisionamiento

1. Ejecutar `terraform init` para inicializar el directorio con Terraform.
2. Ejecutar `terraform validate` para validar la sintaxis de los archivos de Terraform.
3. Ejecutar `terraform plan` para ver los recursos que se crearán.
4. Ejecutar `terraform apply` para aplicar los cambios y aprovisionar la infraestructura.
5. Ejecutar `terraform refresh` para actualizar el archivo de estado de Terraform si se realiza alguna modificación directa en AWS mediante la consola.
6. Ejecutar `terraform destroy` para deshacer todo el aprovisionamiento respectivamente.