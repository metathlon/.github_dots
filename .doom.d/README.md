Si estas leyendo esto y te parece buena idea usar mi configuración... que no te
pase nada, no me hago responsable de la muerte de tu ordenador, tus mascotas o
de cualquier otra catatrofe que pueda aparecer en tu vida como resultado de usar
esta abominación.

Además no tengo ni idea de lo que estoy haciendo, francamente


# Gestión de calendario

## Instalación
Lo primero es instalar el paqute org-caldav, agregando:

``` (setq
(package! oauth2)
(package! org-caldav) 
```

Se necesitan ambos para que esto funcione

## Configuración en la parte de Google
Ahora hace falta configurar org-caldav y si usas google calendar necestias
seguir estos pasos. *SE FLEXIBLE*, he reproducido el proceso lo mejor que he
podido pero podría haberme saltado algún paso, usa esto como una guía, no como
instrucciones detalladas:

   - Tienes que "crear" una nueva aplicación: https://console.developers.google.com/apis/credentials
   - Tienes que "fingir" que estas creando una nueva aplicación para distribuirla, así que una vez creada:
     - Entras en "Pantalla de consentimiento":
       - Tienes que darle premiso a tu aplicación para ver el calendario, pero
         no está listado (para mi no lo estaba)
         - Le das a "API habilitadas", buscas calendar y habilitas Google
           Calendar API. Pide mucha información, yo he puesto:
               - Que uso: Google Calendar API
               - Que es para OTRA UI (por ejemplo, windows, herramienta CLI)
               - Que quiero acceder a los datos del usuario
               - Tienes que crear las credenciales para el proyecto, le das y
                 pide un nombre "usuario_org_calendar_oauth" he puesto yo
                 cambiando usuario por mi usuario. Hasta donde yo entiendo este
                 nombre DA IGUAL, yo he puesto este para que si lo veo en alguna
                 parte sepa de donde narices sale.
                    - Esto me ha generado un ID y me permite descargar un
                      archivo, creo que solo necesito el ID
                    
       - Ahora en la pantalla de credenciales ya tengo el OAuth2
       - Si entro en "Pantalla de consentimiento" ahora SI que me aparecen las
         API del calendario, le doy acceso a todo lo que sale de Google Calendar
         API (ya veremos si hay algo que restringir)
       - En la pantalla de Credenciales
         [https://console.developers.google.com/apis/credentials] del projecto
         ves tu credencia OAuth2, le das y te dice el ID del cliente y el
         Secreto del cliente:
            - El ID del Cliente va en org-caldav-oauth2-client-id:
              - Añade ```(setq org-calendar-oauth-client-id "xxxxxXxXxxxXXxxXXxxxXX" )```
            - El secreto de cliente va en org-caldav-oauth2-client-secret
              - Añade ```(setq org-calendar-oauth-client-secret
                "xxxxxXxXxxxXXxxXXxxxXX" )```
       - Actualmente la variable org-caldav-url tiene una dirección generica de
         un calendario, cambia esa dirección por 'google ```(setq
         org-caldav-url 'google ```
       - Hace falta configurar el calendario, así que org-caldav-calendar-id
         debe tener el identificador del calendario:
            - En el caso de Google hace falta ir al calendario, darle a
              propiedades y el ID es lo que hay al lado de la dirección, algo
              así como ID@group.calendar.google.com Copias todo, incluido el
              group.calendar.google.com
       - Cuando sincronices con google tendrás que identificarte, para esto
         necesitas un navegador que permita usar javascript, asegurate de que
         browser-url-browser-function apunta a un navegador que permita esto.
            - ```(defvar browse-url-browse-funcion 'browse-url-firefox)```
            - Esto solo necesitas hacerlo la primera vez con lo que podrías
              configurarlo aquí y luego simplemente quitarlo O si quieres
              configurarlo para tu Emacs en general, este probablemente no sea
              el sitio, yo lo pondría en config.el
            - Si quieres que emacs guarde tus credenciales de forma segura y así
              evitar que te esté preguntando todo el rato tienes que configurar
              ```(setq plstore-cache-passphrase-for-symmetric-encryption t)```

## Configuración general

Yo de configurar el sistema este aún no tengo mucha idea, te recomiendo que
revises org-caldav.config.el porque he dejado instrucciones sobre como incluir
toda la información que necesitas para que el calendario de google funcione,
además hay partes de configuraciones que he ido cogiendo de aquí y allá o que he
retocado, pero la base principal es de un post de reddit: https://www.reddit.com/r/orgmode/comments/8rl8ep/making_orgcaldav_useable/


Por lo demás es cuestión de ir probando cosas.

TODO: Shortcut para lanzarlo automáticamente y cosas así


            
