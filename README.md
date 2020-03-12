# dots para bspwm
En este repositorio está mi configuración para BSPWM

Este git tiene el directorio de trabajo "desplazado"

Como lo que quiero es controlar mi home (/home/caronte/) y el repositorio esta en /home/caronte/GIT/dots_bspwm la solución ha sido cambiar el directorio de trabajo:

* Creamos el directorio VACIO (en mi caso .github_dots) (OJO AL --bare)

        git init --bare ~/.github_dots

* Añadimos a .bashrc un alias para la gestión de nuestro repositorio de configuraciones (OJO AL DIRECTORIO)

        echo "alias config='/usr/bin/git --git-dir=$HOME/.github_dots/ --work-tree=$HOME'" >> .bashrc
        source .bashrc

* Configuramos el repositorio para que no muestre los archivos que no estan añadidos (o aparecerán mil archivos)

        config config --local status.showUntrackedFiles no

* Comprobamos que ha funcionad

		config status

* Añadimos un fichero

		touch ~/README.md
		config add README.md

* Hacemos el commit, si no tienes configurado tu usuario y nombre es el momento

		config commit -am "Primer commit"

* Añadimos el repositorio remoto que hemos creado en GitHub
	
		config remote add origin http://github.com/usuario/repositorio.git

* Hacemos el primer push (pedira usuario y contraseña, se los damos claro)
	
		config push -u origin master


A partir de este momento podemos usar config

	config status
	config add ~/.config/polybar
	config commit -am "Mensaje commit"
	config push



A correr

## Dependencias

Paquetes que tienes que descargar para que esto funcione como debe, los comandos de instalación puestos son de arch, si usas otra distribución cambialos como corresponda.

* Inprescindibles
	* [bspwm](https://wiki.archlinux.org/index.php/Bspwm): pacman -Syu bspwm
	* [sxhkd](https://wiki.archlinux.org/index.php/Sxhkd): pacman -Syu sxhkd
	* [rofi-dmenu](https://wiki.archlinux.org/index.php/Rofi): yay -Syu rofi-dmenu
	* [polybar](https://wiki.archlinux.org/index.php/Polybar): pacman -Syu polybar
	* [termite](https://github.com/b-ryan/powerline-shell): pacman -Syu termite
		* claramente puedes usar la que quieras pero acuerdate de cambiarlo en ./config/sxhkd/sxhkdrc
* Utiles
	* [powerline-shell](https://github.com/b-ryan/powerline-shell): sudo pip install powerline-shell
    	* Recuerda añadir la función a .bashrc
	* [i3lock-fanzy-dualmonitor](https://aur.archlinux.org/packages/i3lock-fancy-dualmonitors-git/): yay -Syu i3lock-fanzy-dualmonitor
	* [nitrogen](https://wiki.archlinux.org/index.php/Nitrogen): pacman -Syu nitrogen
		* Si no usas nitrogen cambialo por el programa que quieras en ./config/bspwm/bspwmrc o quitas la entrada
