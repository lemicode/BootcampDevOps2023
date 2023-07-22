# Desafío Opcional No 1

## Instalación de Grafana, Prometheus, Node Exporter, Jenkins mediante Ansible

### Estructura de directorios

SOLUCIÓN_DESAFíO_OPCIONAL_1/
├── config/
│   ├── node_exporter.service.j2
│   ├── prometheus.yml.j2
│   └── prometheus.service.j2
├── packages/
│   ├── grafana.yml
│   ├── jenkins.yml
│   ├── node_exporter.yml
│   └── prometheus.yml
├── inventory.ini
├── main.yml

#### config/

Contiene los archivos de configuración de los servicios a instalar.

- node_exporter.service.j2: Archivo de configuración del servicio node_exporter.
- prometheus.yml.j2: Archivo de configuración de prometheus.
- prometheus.service.j2: Archivo de configuración del servicio prometheus.

#### packages/

Contiene los archivos de instalación de los servicios a instalar.

- grafana.yml: Archivo de instalación de grafana.
- jenkins.yml: Archivo de instalación de jenkins.
- node_exporter.yml: Archivo de instalación de node_exporter.
- prometheus.yml: Archivo de instalación de prometheus.

#### inventory.ini

Contiene la información de los hosts a configurar.

#### main.yml

Contiene las tareas a ejecutar.
