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
        ("STARTED" . (:foreground: "green" :weight bold))
        ("CANCELED" . (:foreground "yellow" :background "red" :weight bold))
        ("DONE" . (:foreground "grey" :weight bold))
        )
)

;; --- Configuración de PRIORIDADES
(setq org-highest-priority ?A)
(setq org-default-priority ?B)
(setq org-lowest-priority ?C)

;; --- si quieres que la semana empice en lunes
;; (setq org-agenda-start-on-weekday 1)


;; --- si quieres que se muestre solo HOY
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-start-day "+0d")
(setq org-agenda-span 1)

;; (setq org-agenda-time-grid '((daily today) nil "----------------------" nil))


;; (setq org-agenda-time-grid
;;   '((daily today require-timed)
;;     (800 1000 1200 1400 1600 1800 2000)
;;     "......"
;;     "----------------"))

;; --- Configuración de super-agenda
(load! "org-super-agenda.conf.el")
(add-hook! 'org-agenda-mode-hook org-super-agenda-mode)
;;================================================================================
;;              VISTA DE AGENDA PERSONALIZADA
;;================================================================================
;; Lo que pretendemos hacer es algo así, ejemplo de agenda
;;
;; MAXIMA PRIORIDAD:
;; * tarea 1
;; * tarea 2
;; ========================
;; AGENDA DEL DIA
;; ========================
;; Otras tareas de menos prioridad:
;; * tarea 3
;; * tarea 4
;;
;;

;; Uno de los problemas a los que nos enfrentamos es separar las priridades, para eso está esta funcion
(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

  PRIORITY may be one of the characters ?A, ?B, or ?C."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-lowest-priority priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))

;; Esta funcion es para filtrar "habitos", por si me da por usarlos, que no creo
(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

;; -- Vista de agenda personalizada
;; (setq org-agenda-custom-commands
;;       '(("c" "Daily agenda and all TODOs"
;;          ((tags "PRIORITY=\"A\""
;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
;;                  (org-agenda-overriding-header "High-priority unfinished tasks:")))
;;           (agenda "" ((org-agenda-span 1)))
;;           (alltodo ""
;;                    ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
;;                                                    (air-org-skip-subtree-if-priority ?A)
;;                                                    (org-agenda-skip-if nil '(scheduled deadline))))
;;                     (org-agenda-overriding-header "ALL normal priority tasks:"))))
;;          ((org-agenda-compact-blocks t)))))
;; --- Vista de agenda por defecto
(defun org-agenda-custom-view (&optional arg)
  (interactive "P")
  (org-agenda arg "z"))

(define-key car-map (kbd "a") 'org-agenda-custom-view )

;;=========================================================================
;;                           TECLAS
;;=========================================================================
(require 'org-capture)
(require 'org-agenda)

(global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-ca" 'org-agenda)

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
;;              ORG-LOG
;;=========================================================================
;; Guarda cuando se ha terminado una tarea
(setq org-log-done 'time)
;; Guarda cuando se ha cambiado la fecha de una tarea
(setq org-log-reschedule 'time)
;; Guarda cuando se ha cambiado la ubicación de una tarea (de un archivo a otro)
(setq org-log-refile 'time)
;; Guarda cuando se ha cambiado la fecha limite de una tarea
(setq org-log-redeadline 'time)
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
	  ("t" "To Do Item" entry (file caronte/org-agenda-FILE-tareas)
	   "* TODO %^{Description}\n%U\n%?" :prepend t)
    ("r" "Receta Manual" entry (file caronte/org-agenda-FILE-recetas)
      "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
    ;; ("R" "Receta Automatica" entry (file caronte/org-agenda-FILE-recetas)
	  ;;  "%(org-chef-get-recipe-from-url)" :empty-lines 1)
    ;; ("i" "org-protocol-capture" entry (file caronte/org-agenda-FILE-inbox)
	  ;;  "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
    ("e" "email" entry (file caronte/org-agenda-FILE-emails)
      "* TODO %^{Descripcion_Breve} [#C] EMAIL: %a\nFROM: %:from:\nSUBJECT: %:subject\n%U\n" :clock-in t :clock-resume t)
     ;; "* TODO %^{Descripcion_BREVE} [#A] Reply: %a\n%U" :prepend t)
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


;;=========================================================================
;;           BORRADO DE TEMPORALES LaTeX
;;
;; Cuando haces una exportación desde ORG-MODE a PDF usamos latex y genera mil archivos intermedios que dejan el directorio hecho un asco.
;; Esto pretende solucionar precisamente eso.
;;=========================================================================i
(setq org-latex-logfiles-extensions '("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl"))
(setq org-latex-remove-logfiles t)
