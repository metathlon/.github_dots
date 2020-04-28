;;==============================================================================================
;;
;;         CONFIGURACION gcal
;;----------------------------------------------------------------------------------------------
;; Esta configuración está basada en: https://cestlaz.github.io/posts/using-emacs-26-gcal/
;;==============================================================================================


;; -- Loading personal config
(load! "org-gcal.personal.el")



;; --------------------------------- A PARTIR DE ESTE PUNTO ES CONFIGURACION PERSONAL ----------------------
;; Recomiendo que la muevas a un fichero específico como he hecho yo
;; ---------------------------------------------------------------------------------------------------------

;;========================================================================================================
;; Las secciones comentadas a continuación son las que yo tengo dentro de org-gcal.personal.config.el
;; Dejo aquí las secciones y ejemplos de cómo deben ser rellenadas.
;; Completando estos datos debería funcionarte sin problemas
;;
;; OJO!!!!!!
;; La primera vez deberias:
;; * Rellenar los campos
;; * Guardar y cerrar
;; * Arrancar
;; * EJECUTAR ANTES QUE NADA: org-gcalendar-fetch.
;;
;; Esto es super importante, porque ANTES DE SINCRONIZAR quieres que se descargue lo que ya hay en los calendarios
;; Si no haces eso podrías borrar los calendarios enteros!
;;========================================================================================================


;; -------------------------------------------------------------------------------------------------------
;; -- Una de las cosas que NECESITAS es añadir los archivos donde se sincronizan los calendarios a la agenda
;; Yo lo tengo solucionado en org.el, añadiendo todos los archivos que es encuentran en un directorio concreto
;;
;; Si no quieres hacerlo así puedes usar el codigo que hay acontinuación
;; ---------------------------------------------------------------------------------
;; (setq org-agenda-files (list "~/orgfiles/gcal.org"
;;                               "~/orgfiles/cosas.org"))


;; -------------------------------------------------------------------------------------------------------
;;  --- Calendarios que vamos a sincronizar
;;  Cambia los datos por los tuyos y debería de sincronizarse sin mucho problema
;; -------------------------------------------------------------------------------------------------------
;; (setq org-gcal-client-id "xxxxxxxxxxxxxxxx.apps.googleusercontent.com" )
;; (setq org-gcal-client-secret "xxxxxxxxxxxxxxxxx")
;; (setq org-gcal-file-alist
;;       '(
;;         ;;----------------------------------------------------------------------------------------
;;         ;; Calendario basico asignado a ORG-MODE
;;         ;; ---------------------------------------------------------------------------------------
;;         ("xxxxxxxxxxxxxxxxxx@group.calendar.google.com" . "~/google_drive/ORG/GCAL_events.org")
;;         ("xxxxxxxx@gmail.com" . "~/google_drive/ORG/GCAL_gmail_events.org")
;;         )
;; )

;; --------------------------------------------------------------------------------------------------------
;; -- Es cómodo tener templates para la agenda, así determinadas cosas se guardan en determinados archivos
;; Igual que lo anterior, yo para no liar la configuracion de nadie dejo esto comentado y lo pongo en mi
;; configuracion privada, simplemente descomenta y ajusta las rutas
;;
;; Recomiendo AÑADIR a la lista de captura, de forma que los templates que ya existan no se rompan
;; --------------------------------------------------------------------------------------------------------
;; --- Duplica esta linea tantas veces como sea necesario con los valores adecuados
;; (add-to-list 'org-capture-templates
;; 	  '("p" "GCal Personal" entry (file caronte/org-agenda-FILE-calendario-personal)
;; 	    "* %?\n:PROPERTIES:\n:calendar-id: xxxxxxxxxxxxxxxxx@group.calendar.google.com\n:END:\n:org-gcal:\n%^T\n:END:\n")
;; )


;; -- ahora lo que vamos es a sincronizar los calendarios con la agenda
;; Yo esta seccion la tengo quitada, lo hago a mano, porque me pone negro que al cerrar intente sincronizar si o si
;; --------------------------------------------------------------------------------------------------------
;; (add-hook 'org-agenda-mode-hook (lambda() (org-gcal-sync)))
;; (add-hook 'org-capture-after-finalize-hook (lambda()(org-gcal-sync)))


