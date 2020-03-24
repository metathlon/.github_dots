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
 echo "TuClaveDeCorreo" >> .mail/correo_auth_texto
 gpg2 --output ~/.mail/correo_auth.gpg --symmetric ~/.mail/correo_auth_texto
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
mu init -m ~/.mail
mu index
```

*IMPORTANTE*
Si tienes más de una cuenta no ejecutes ```mu init -m ~/.mail/correo``` para
cada cuenta, porque solo puedes "incializar" un correo. Lo que debes es
configurar todas, hcaer la sincronización de todas y finalmente hacer el init
sobre .mail/ y no sobre cada carpeta individual


Si has llegado hasta aquí sin problemas **RECUERDA** tienes que borrar el
archivo que generaste con la clave sin cifrar:

```bash
 rm ~/.mail/correo_auth_texto
```

Que no se te olvide!

En este punto ya puedes usar directamente la configuración que hay en .doom.d/config.el

# emacs doom

Si usas emacs doom (que es una maravilla) puede que el menú principal de mu4e
(M-x, mu4e) no te funcione, para arreglarlo tienes que añadir a tu config.el

```
(remove-hook 'mu4e-main-mode-hook 'evil-collection-mu4e-update-main-view)
```

Al parecer el hook viene de serie pero el paquete que lo usa no (creo que es
evil-mu4e). La otra opción es buscar el paquete que usa ese hook e instalarlo,
preferiblemente al estilo doom (usando pacakges.el)
