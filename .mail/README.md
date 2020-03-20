 # Configuracion de correo para mu4e
 
 Lo primero es asegurarte de que tienes instalado mu (instalará mu4e al mismo
 tiempo)
 
 Después lo que necesitas es generar los archivos de configuración (yo he hecho
 uno por cuenta):
 
 ``` bash
 mkdir .mail
 touch .mail/.mbsyncrc_correo
 ```
     
 Ahora que tienes el archivo de configuración tienes que llenarlo de cosas
 
 Una de las configuraciones del archivo verás que es PassCmd y que apunta a un
 fichero gpg:
 
 ```bash
 cat TuClaveDeCorreo >> .mail/correo_auth_texto
 gpg2 --output ~/.mail/correo_auth.gpg --symmetric ~/.mail/correo_auth
 ```
 
 Ahora que tienes el archivo cifrado debería de funcionar la identificación y
 deberías poder sincronizar el correo:
 
 ```bash
 mbsync -c ~/.mail/.mbsyncrc_correo -a
 ```

Es posible que se queje sobre que faltan directorios... crea los que sean
necesarios (depende de la configuración que hayas hecho)

Finalmente indexa los correos, en mi caso como tengo varios los tengo cada uno
en una carpeta, primero slo inicializaría todos y por último los indexaría.

```bash
mu init ~/.mail/correo/
mu index
```

Si has llegado hasta aquí sin problemas ya puedes usar directamente la
configuración que hay en .doom.d/config.el

