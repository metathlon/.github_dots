;;; ~/.doom.d/org.el -*- lexical-binding: t; -*-



;;=========================================================================
;;                          ARCHIVOS en la agenda
;;=========================================================================
;; Esta deberia ser siempre la primera asignación, para el esto usar add-to-list
;; (setq org-agenda-files (list (concat caronte/org-agenda-directory "LINKS.org")
;; 		             (concat caronte/org-agenda-directory "TAREAS.org"))
;; )
(after! org
  (require 'find-lisp)
  ;;-----------------------------------------------------------
  ;; en este archivo guardo la configuración personal
  ;;-----------------------------------------------------------
  ;; --- Por ejemplo
  ;; (setq caronte/org-agenda-directory "~/blablalba/ORG/")
  (load! "org.personal.el")

  ;; -- Metemos en agenda TODOS los archivos que hay en el directorio que he configurado en org.persojnal.el
  ;; La idea es que ahí tendré los TODO de proyectos, asesoramientos, personales... y como todo son cosas que hay que hacer... pues tanto da
  (setq org-agenda-files
        (find-lisp-find-files caronte/org-agenda-directory "\.org$"))
)



;;=========================================================================
;;                           TECLAS
;;=========================================================================
(require 'org-capture)
(require 'org-agenda)

(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)

;; --- Estas dos funciones no son necesarias, pero están para ver QUE HACEN LAS TECLAS
;; Es decir... le das a C-2 y entonces te salen opciones:
;; t -> caronte/open-file-TAREAS
;; l -> caronte/open-file-LINKS
;;
;; -- Sin las fuciones tetndría este aspecto:
;; t -> lambda()
;; l -> lambda()
;; --------------------------------------------------------------------------------------
(defun caronte/open-file-TAREAS ()
  (interactive)
  (find-file (concat caronte/org-agenda-directory "TAREAS.org"))
)
(defun caronte/open-file-LINKS ()
  (interactive)
  (find-file (concat caronte/org-agenda-directory "LINKS.org"))
)

(define-key car-org-map (kbd "t") 'caronte/open-file-TAREAS)
(define-key car-org-map (kbd "l") 'caronte/open-file-LINKS)

;;=========================================================================
;;               Avisos cuando vas a cerrar un frame de captura
;;=========================================================================
(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(defadvice org-capture-destroy
    (after delete-capture-frame activate)
  "Advise capture-destroy to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

;;=========================================================================
;;              Perfiles de captura
;;=========================================================================
(setq org-capture-templates
  '(
    ("c" "Cita" entry (file ( lambda () (concat caronte/org-agenda-directory "GCAL_udaic_events.org")))
	    "* TODO: %?\n%^T\n") ;; -- creo que es buena idea añadir el TODO, de forma que aparezca en la agenda, siempre puedo quitarlo
	  ("p" "Cita Personal" entry (file ( lambda () (concat caronte/org-agenda-directory "GCAL_ORG_MODE_events.org")))
	    "* TODO: %?\n%^T\n") ;; -- creo que es buena idea añadir el TODO, de forma que aparezca en la agenda, siempre puedo quitarlo
	  ("t" "To Do Item" entry (file+headline ( lambda () (concat caronte/org-agenda-directory "TAREAS.org")) "COSAS QUE HACER")
	   "* TODO %^{Description}\n%U\n%?" :prepend t)
	  ("i" "org-protocol-capture" entry (file ( lambda() (concat caronte/org-agenda-directory "INBOX.org")))
	   "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
    ("e" "email" entry (file+headline ( lambda() (concat caronte/org-agenda-directory "EMAILS.org")) "EMAILS")
     "* TODO [#A] Reply: %a " :immediate-finish t)
    ("l" "Link" entry (file+headline ( lambda() (concat caronte/org-agenda-directory "LINKS.org")) "LINKS")
	    "* %? %^L %^g \n%T" :prepend t)
	  )
)
