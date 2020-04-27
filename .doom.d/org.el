;;; ~/.doom.d/org.el -*- lexical-binding: t; -*-



;;=========================================================================
;;                          ARCHIVOS en la agenda
;;=========================================================================
;; Esta deberia ser siempre la primera asignación, para el esto usar add-to-list
;; (setq org-agenda-files (list (concat caronte/org-agenda-FILE-"LINKS.org")
;; 		             (concat caronte/org-agenda-FILE-"TAREAS.org"))
;; )
(after! org
  (require 'find-lisp)
  ;;-----------------------------------------------------------
  ;; en este archivo guardo la configuración personal
  ;;-----------------------------------------------------------
  ;; --- Por ejemplo
  ;; (setq caronte/org-agenda-FILE-"~/blablalba/ORG/")
  (load! "org.personal.el")

  ;; -- Metemos en agenda TODOS los archivos que hay en el directorio que he configurado en org.persojnal.el
  ;; La idea es que ahí tendré los TODO de proyectos, asesoramientos, personales... y como todo son cosas que hay que hacer... pues tanto da
  (setq org-agenda-files
        (find-lisp-find-files caronte/org-agenda-directory"\.org$"))
)

;; --- Configuración de TODOS
(setq org-todo-keywords
      '(
        (sequence "TODO(t)" "STARTED(s)" "|" "DONE(d)" "CANCELED(c)")
        )
)

(setq org-todo-keyword-faces
      '(
        ("TODO" . (:foreground "yellow" :weight bold))
        ("STARTED" . ("green" :weight bold))
        ("CANCELED" . (:foreground "yellow" :background "red" :weight bold))
        ("DONE" . (:foreground "grey" :weight bold))
        )
)


;; --- function to access agenda and todo
(defun org-agenda-show-agenda-and-todo (&optional arg)
  (interactive "P")
  (org-agenda arg "n"))
(define-key car-map (kbd "a") 'org-agenda-show-agenda-and-todo)

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
  (find-file caronte/org-agenda-FILE-tareas)
)
(defun caronte/open-file-LINKS ()
  (interactive)
  (find-file caronte/org-agenda-FILE-links)
)
(defun caronte/open-file-EMAILS()
  (interactive)
  (find-file caronte/org-agenda-FILE-emails)
)
(defun caronte/open-file-RECETAS()
  (interactive)
  (find-file caronte/org-agenda-FILE-recetas)
)
(defun caronte/open-file-CALENDARIO-PERSONAL()
  (interactive)
  (find-file caronte/org-agenda-FILE-calendario-personal)
)
(defun caronte/open-file-CALENDARIO-TRABAJO()
  (interactive)
  (find-file caronte/org-agenda-FILE-calendario-trabajo)
)
(defun caronte/open-file-ESTADISTICA()
  (interactive)
  (find-file caronte/org-agenda-FILE-estadistica)
)
(defun caronte/open-file-ESTUDIOS()
  (interactive)
  (find-file caronte/org-agenda-FILE-estudios)
)

(define-key car-org-map (kbd "t") 'caronte/open-file-TAREAS)
;; (define-key car-org-map (kbd "l") 'caronte/open-file-LINKS)
;; (define-key car-org-map (kbd "e") 'caronte/open-file-EMAILS)
(define-key car-org-map (kbd "r") 'caronte/open-file-RECETAS)
;; (define-key car-org-map (kbd "c") 'caronte/open-file-CALENDARIO-PERSONAL)
;; (define-key car-org-map (kbd "C") 'caronte/open-file-CALENDARIO-TRABAJO)
(define-key car-org-map (kbd "e") 'caronte/open-file-ESTADISTICA)
(define-key car-org-map (kbd "d") 'caronte/open-file-ESTUDIOS)
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
	  ("t" "To Do Item" entry (file+headline caronte/org-agenda-FILE-tareas "COSAS QUE HACER")
	   "* TODO %^{Description}\n%U\n%?" :prepend t)
    ("r" "Receta Manual" entry (file caronte/org-agenda-FILE-recetas)
      "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
    ;; ("R" "Receta Automatica" entry (file caronte/org-agenda-FILE-recetas)
	  ;;  "%(org-chef-get-recipe-from-url)" :empty-lines 1)
    ;; ("i" "org-protocol-capture" entry (file caronte/org-agenda-FILE-inbox)
	  ;;  "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
    ;; ("e" "email" entry (file+headline caronte/org-agenda-FILE-emails "EMAILS")
    ;;  "* TODO %^{Descripcion_BREVE} [#A] Reply: %a\n%U" :prepend t)
    ;; ("l" "Link" entry (file+headline caronte/org-agenda-FILE-links "LINKS")
	  ;;   "* %? %^L %^g \n%T" :prepend t)

	  )
)



;;=========================================================================
;;             Checkbox para tabla
;;=========================================================================
(defun check-cell ()
  (interactive)
  (let ((cell (org-table-get-field)))
    (if (string-match "[[:graph:]]" cell)
        (org-table-blank-field)
      (insert "X")
      (org-table-align))
    (org-table-next-field)))

;;=========================================================================
;;            EJECUCION DE CODIGO R en ORG-MODE
;;=========================================================================
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))
