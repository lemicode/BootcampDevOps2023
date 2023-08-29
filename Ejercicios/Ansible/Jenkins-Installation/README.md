# Instalación de Jenkins con Ansible

## Ejecución

```bash
ansible-playbook -i inventory.ini playbook.yml -u dev -K
```

## Forma para conocer la clave inicial de Jenkins

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```