## Ejecución de un pipeline de Jenkins

En el documento [Evidencia.pdf](Evidencia.pdf) se observa un error en la ejecución del pipeline.

![img-1](img/1.png)

Una solución para ello es agregar el usuario jenkins al archivo sudoers mediante el comando ```sudo visudo```, **sólo para efectos de prueba en un ambiente local o sandbox**.

![img-2](img/2.png)

Por último si es necesario se puede agregar el usuario jenkins al grupo sudo mediante el comando ```sudo usermod -aG sudo jenkins```.

Con lo anterior, debería solucionarse el error en cuestión.

![img-3](img/3.png)