;;==============================================================================================
;;
;;         CONFIGURACION gcal
;;----------------------------------------------------------------------------------------------
;; Esta configuración está basada en: https://cestlaz.github.io/posts/using-emacs-26-gcal/
;;==============================================================================================

;; -- Una de las cosas que NECESITAS es añadir los archivos donde se sincronizan los calendarios a la agenda
;; Si tienes un archivo de agenda hazlo allí, si no lo puedes hacer aqui, yo lo tengo en mi config personal
;; ---------------------------------------------------------------------------------
;; (setq org-agenda-files (list "~/orgfiles/gcal.org"
;;                               "~/orgfiles/cosas.org"))


;; -- Es cómodo tener templates para la agenda, así determinadas cosas se guardan en determinados archivos
;; Igual que lo anterior, yo para no liar la configuracion de nadie dejo esto comentado y lo pongo en mi
;; configuracion privada, simplemente descomenta y ajusta las rutas
;; --------------------------------------------------------------------------------------
;; (setq org-capture-templates
;; '(("c" "Cita" entry (file  "~/orgfiles/gcal.org" )
;;       "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
;;   ("l" "Link" entry (file+headline "~/orgfiles/links.org" "Links")
;;   "* %? %^L %^g \n%T" :prepend t)
;;   ("t" "To Do Item" entry (file+headline "~/orgfiles/cosas.org" "To Do")
;;   "* TODO %?\n%u" :prepend t))
;; )


;; -- ahora lo que vamos es a sincronizar los calendarios con la agenda
(add-hook 'org-agenda-mode-hook (lambda() (org-gcal-sync)))
(add-hook 'org-capture-after-finalize-hook (lambda()(org-gcal-sync)))



;; -- Loading personal config
(load! "org-gcal.personal.el")
