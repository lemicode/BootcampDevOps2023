# Instalación de Jenkins con Ansible

```bash
ansible-playbook -i inventory.ini playbook.yml -u dev -K
```

## Forma para conocer la clave inicial de Jenkins

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

## Pasos para reiniciar la clave del usuario principal de Jenkins

1. Hacer backup del archivo /var/lib/jenkins/config.xml
2. Ingresar al archivo /var/lib/jenkins/config.xml con privilegios sudo.
3. En la sección <useSecurity>true</useSecurity> cambiar a false.
4. Reiniciar Jenkins (sudo systemctl restart jenkins).
5. Mediante un navegador ingresar a http://localhost:8080/manage/configureSecurity/
6. En la sección Authentication, en la lista desplegable *Security Realm*, seleccionar **Jenkins’ own user database** y guardar cambios.
7. Ingresar a http://localhost:8080/asynchPeople/
8. Seleccionar el usuario principal de Jenkins.
9. Click en la opción Configure.
10. Modificar la clave en la sección Password y guardar cambios.
11. Volver a la URL http://localhost:8080/manage/configureSecurity/ y en la sección Authentication, seleccionar un ítem de la lista desplegable *Authorization*; por ejemplo para efectos de prueba únicamente en localhost, se podría seleccionar **Logged-in users can do anything**, en cuyo caso debería desactivarse la opción **Allow anonymous read access**.
12. Guardar cambios.
13. Cerrar la(s) pestaña(s) del navegador donde Jenkins se encuentre abierto.
14. Reiniciar Jenkins (sudo systemctl restart jenkins).
15. Restablecer el backup del paso 1.
16. Ingresar a http://localhost:8080 y verificar que el usuario pueda ingresar con la nueva clave.