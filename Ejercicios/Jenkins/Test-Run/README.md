### Prueba de ejecución de un pipeline de Jenkins

En el documento [Evidencia.pdf](Evidencia.pdf) se observa un error en la ejecución del pipeline.

![1](img/1.jpg)

Una solución para ello es agregar el usuario jenkins al archivo sudoers mediante el comando ```bash sudo visudo```, **sólo para efectos de prueba en un ambiente local o sandbox**.

![2](img/2.jpg)

Por último si es necesario se puede agregar el usuario jenkins al grupo sudo mediante el comando ```bash sudo usermod -aG sudo jenkins```.

Con lo anterior, debería solucionarse el error en cuestión.

![3](img/3.jpg)