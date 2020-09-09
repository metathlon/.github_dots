;;; ~/.doom.d/nueva_config/org.calendario.config.el -*- lexical-binding: t; -*-

;; *** Org-Caldav
;; **** TODO Configuración básica
;; Hay que configurar el backup y gestionarlo, pero aún no tengo claro cómo
;; #+BEGIN_SRC emacs-lisp
    ;; (setq org-caldav-backup-file)
    (setq org-caldav-sync-changes-to-org "all")
    (setq cfw:org-overwrite-default-keybinding t)
    (setq org-icalendar-include-sexps t)
    (setq org-caldav-delete-calendar-entries "ask")
;;     ;; (setq org-gcal-token-file)
;; #+END_SRC
;; **** Configuración personal
;; Esta es la que no subo a github
;; #+BEGIN_SRC emacs-lisp
    (load! "org-caldav.personal.config.el")
;; #+END_SRC
;; ***** Ejemplo del archivo de configuración personal
;; Para mostrar los diferentres calendarios uso [[github:https://github.com/kiwanami/emacs-calfw][emacs-calfw]] como se puede ver en
;; este ejemplo.
;; ****** Base calfw
;; #+BEGIN_SRC emacs-lisp
;; ;; (use-package! calfw
;; ;;    :config
;; ;;    (require 'calfw)
;; ;;    (require 'calfw-org)
;; ;;    (require 'calfw-ical)

;; ;;    (defun caronte/open-calendar ()
;; ;;    (interactive)
;; ;;    (cfw:open-calendar-buffer
;; ;;    :contents-sources
;; ;;    (list
;; ;;    ;; (cfw:org-create-source "Green")  ; orgmode source
;; ;;    (cfw:ical-create-source "TRABAJO-COMPARTIDO" "URL-A-iCal-CALENDAR-URL" "IndianRed")
;; ;;    (cfw:ical-create-source "TRABAJO-MIO" "https://calendar.google.com/calendar/ical/..../basic.ics" "green") ; google calendar ICS
;; ;;    )))
;; ;;    (setq cfw:org-overwrite-default-keybinding t)
;; ;;  )
;; ;;  (require 'calfw-gcal)
;; #+END_SRC

;; ****** Base caldav
;; No he conseguido poder abstraer esta configuración de los literales, si pudiera
;; poner en variables lo correspondiente a =:files= y al =:calendar-id= estaría
;; genial porque solo necesitaría un fichero personal con esos nombres de
;; variables, lo que haría mucho MUCHO más sencilla la instalación y gestión de
;; esta configuración en github.

;; #+BEGIN_SRC emacs-lisp
;;     ;; (setq org-caldav-oauth2-client-id "xxxxxxxxxxxx.apps.googleusercontent.com")
;;     ;; (setq org-caldav-oauth2-client-secret "xxxxxxxxxxxxxxxxxxx")
;;     ;;
;;     ;; La siguiente linea SE SUPONE que es para guardar las contraseñas y no tener que ponerlas mil veces
;;     ;; Además de que YA la tengo puesta (al principio del archivo), caldav no la respeta
;;     ;; no se como arreglarlo pero mu4e si que respeta el setting pero caldav no
;;     ;; (setq plstore-cache-passphrase-for-symmetric-encryption t)
;;     ;; (setq org-caldav-url 'google)
;; #+END_SRC

;; En la siguiente lista meteremos tantos calendarios como queramos, solo hay que
;; copiar y pegar.
;; #+BEGIN_SRC emacs-lisp
;;     ;; (setq org-caldav-calendars
;;     ;;     '(
;;     ;;     ;;----------------------------------------------------------------------------------------
;;     ;;     ;; Calendario basico asignado a ORG-MODE
;;     ;;     ;; ---------------------------------------------------------------------------------------
;;     ;;     (:calendar-id "xxxxxxxxxxxxxxx@group.calendar.google.com"
;;     ;;                 :files ("~/xxxxxxx/ORG/ACTIVOS/GCAL_ORG_MODE_events.org" )
;;     ;;                 :inbox "~/xxxxxxx/ORG/ACTIVOS/GCAL_ORG_MODE_events_inbox.org"
;;     ;;     )
;;     ;; )
;; #+END_SRC
;; ****** Capture templates
;; De estos tengo uno por cada calendario que gestiono
;; #+BEGIN_SRC emacs-lisp
;; ;; --- Calendaro ORG-MODE
;; ;; (add-to-list 'org-capture-templates
;; ;; 	  '("p" "GCal ORG-MODE" entry (file caronte/org-agenda-FILE-calendario-personal)
;; ;; 	    "* %?\n:PROPERTIES:\n:calendar-id: xxxxxxxx@group.calendar.google.com\n:END:\n:org-gcal:\nSCHEDULED:%^T\n:END:\n")
;; ;; )
;; #+END_SRC

;; **** Sincronización (que no nos pase nada)
;; Esto es todo un proceso... lo que quiere decir que odio esta parte y no estoy
;; seguro de qué quiero hacer con ella
;; ***** Funcion de sicronización a la salida
;; Esta sería la función que usaría para guardar buffers y sincronizar el
;; calendario al salir, pero lo cierto es que no la uso porque normalmente no
;; gestiono el calendario desde aquí y sobre todo porque cuando cierro QUIERO
;; CERRAR.

;; La /solución/ que he encontrado es syncronizar cuando guardo un .org, lo que
;; tiene sus propios problemas, pero no me quejo.
;; #+BEGIN_SRC emacs-lisp
;; This is the sync on close function; it also prompts for save after syncing so
;; no late changes get lost
(defun org-caldav-sync-at-close ()
  (org-caldav-sync)
  (save-some-buffers))
;; #+END_SRC

;; ***** Sincronización por tiempo
;; #+BEGIN_SRC emacs-lisp
;; This is the delayed sync function; it waits until emacs has been idle for
;; "secs" seconds before syncing.  The delay is important because the caldav-sync
;; can take five or ten seconds, which would be painful if it did that right at save.
;; This way it just waits until you've been idle for a while to avoid disturbing
;; the user.
;; ==================================================================================
;; La ultima linea NORMALMENTE debería ser:
;;   (* 1 secs) nil 'org-caldav-sync)))
;;
;; En esta config se ha cambiado org-caldav-sync por org-gcal-syn
;; El motivo es que gcal se encarga de mandar eventos desde los archivos ORG a los calendarios
;; caldav (que se encarga de mostrar en un calendario los que ya hay en google calendar) usa otro sistema, los ics
;; y se sincronizan con abrir el propio calendario
;;
;; Así que me estoy aprovechando del sistema de timer de caldav para sincronizar gcal en realidad

(defvar org-caldav-sync-timer nil
    "Timer that `org-caldav-push-timer' used to reschedule itself, or nil.")
(defun org-caldav-sync-with-delay (secs)
  (when org-caldav-sync-timer
    (cancel-timer org-caldav-sync-timer))
  (setq org-caldav-sync-timer
  (run-with-idle-timer
    (* 1 secs) nil 'org-caldav-sync)))

;; #+END_SRC
;; ***** Sincronización tras guardar archivo .org
;; #+BEGIN_SRC emacs-lisp
;; ;; (after! org
;; ;;     (add-hook 'after-save-hook
;; ;;         (lambda ()
;; ;;         (when (eq major-mode 'org-mode)
;; ;;     (org-caldav-sync-with-delay 3))))
;; ;; )
;; #+END_SRC

;; ***** Siconrización al cerrar emacs
;; #+BEGIN_SRC emacs-lisp
;; ;; (add-hook 'kill-emacs-hook 'org-caldav-sync-at-close)
;; #+END_SRC

;; ***** Sincronización al entrar en la agenda
;; #+BEGIN_SRC emacs-lisp
;; (add-hook 'org-agenda-mode-hook 'org-caldav-sync)
;; #+END_SRC

;; ***** Sincronización "personalizada"
;; De momento no está personalizada pero creo que por aquí anda el secreto de matar
;; el resultado de la sincronización, que lo odio a muerte

;; #+BEGIN_SRC emacs-lisp
(defun caronte/org-caldav-sync nil
    "Sincronizar CalDAV"
    'org-caldav-sync)
;; #+END_SRC

;; ***** Org-icalendar
;; De momento esta sección tampoco la estoy usando
;; #+BEGIN_SRC emacs-lisp
    ;; (setq org-icalendar-alarm-time 1)
    ;; This makes sure to-do items as a category can show up on the calendar
    ;; (setq org-icalendar-include-todo t)
    ;; This ensures all org "deadlines" show up, and show up as due dates
    ;; (setq org-icalendar-use-deadline '(event-if-todo event-if-not-todo todo-due))
    ;; This ensures "scheduled" org items show up, and show up as start times
    ;; (setq org-icalendar-use-scheduled '(todo-start event-if-todo event-if-not-todo))
;; #+END_SRC
;; **** Teclas
;; #+BEGIN_SRC emacs-lisp
    ;; (define-key car-map (kbd "s") 'org-caldav-sync)
    (setq cfw:org-overwrite-default-keybinding t)
    (defvar cfw:org-custom-map
    (cfw:define-keymap
    '(
        ("g"   . cfw:refresh-calendar-buffer)
        ("j"   . cfw:org-goto-date)
        ("k"   . org-capture)
        ;; ("q"  . doom-dashboard/open)
        ("q"   . kill-buffer)
        ("d"   . cfw:change-view-day)
        ("v d" . cfw:change-view-day)
        ("v w" . cfw:change-view-week)
        ("v m" . cfw:change-view-month)
        ("x"   . cfw:org-clean-exit)
        ("RET" . cfw:org-open-agenda-day)
        ))
    "Key map for the calendar buffer.")
;; #+END_SRC
