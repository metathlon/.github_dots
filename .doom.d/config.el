;;; ~/.doom.d/nueva_config/config.el -*- lexical-binding: t; -*-

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (org-babel-load-file (expand-file-name file "~/.doom.d/"))
)


;; fuentes
(when (member "Source Code Pro" (font-family-list))
  (setq doom-font (font-spec :family "Source Code Pro" :size 14)))


;; --- THEMES ---
;;
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-dracula)
(setq doom-theme 'doom-nord)
;; (setq doom-theme 'doom-tomorrow-night)
;; (setq doom-theme 'doom-monokai-pro)
;; (setq doom-theme 'doom-palenight)

;; --- DASHBOARD IMAGE ---
(add-hook! '(+doom-dashboard-mode-hook)
           (setq fancy-splash-image "~/dotfiles/emacs/doom.d/images/crypto.png"))



;; --- EMACS BASICS ---
(use-package emacs
  :preface
  (defvar caronte/indent-width 4)
  :config
  (setq
   ring-bell-function        'ignore       ; minimise distraction
   frame-resize-pixelwise    t
   default-directory         "~/"
   confirm-kill-emacs        nil
   )

  (tool-bar-mode -1)
  (menu-bar-mode -1)

  ;; better scrolling experience
  (setq scroll-margin 0
        scroll-conservatively 10000
        scroll-preserve-screen-position t
        auto-window-vscroll nil)

  ;; increase line space for better readability
  (setq-default line-spacing 3)

  ;; Always use spaces for indentation
  (setq-default indent-tabs-mode nil
                tab-width caronte/indent-width))
 (set-frame-parameter (selected-frame) 'alpha '(99 . 95))
 (add-to-list 'default-frame-alist '(alpha . (99 . 80)))

;; --- GESTION CLAVES ---
(setq plstore-cache-passphrase-for-symmetric-encryption t)


;; --- SHELL ---
(setq shell-file-name "bash")

;; --- IDIOMA ESPAÑOL ---
(setq current-language-environment "Spanish")
(setq org-export-default-language "es")

;; use-package must yield to other packages unless said otherwise
(with-eval-after-load 'use-package
  (setq use-package-always-defer t
        use-package-verbose t
        use-package-expand-minimally t
        use-package-compute-statistics t
        ;; use-package-enable-imenu-support t
        ))




;; --- CONFIG MULTIEDIT ---
(load! "multiedit.config.el")
(load! "multicursor.config.el")


(load! "org.personal.config.el") ;; Carga de variables con rutas personales
;; - Este archivo solo tiene una variable con este valor
;; (setq caronte/org-directory "~/GOOGLE_DRIVE/ORG/")
;;
;;
(after! org
  (load! "org.files.config.el") ;; Carga de variables con rutas personales
  (load! "org.config.el") ;; Carga de variables con rutas personales
  (load! "org.capture.config.el")
  (load! "org.contacts.config.el")
  (load! "org.thunderbird.config.el")
  (load! "org.templates.config.el")
  (load! "org.babel.config.el")

  ;; --- LOGS ---
    (setq org-log-done 'time)
    ;; Guarda cuando se ha cambiado la fecha de una tarea
    (setq org-log-reschedule 'time)
    ;; Guarda cuando se ha cambiado la ubicación de una tarea (de un archivo a otro)
    (setq org-log-refile 'time)
    ;; Guarda cuando se ha cambiado la fecha limite de una tarea
    (setq org-log-redeadline 'time)

    ;; --- CHECKBOX EN TABLAS ---
    ;; *** Checkbox en tabla
    ;; Estoy buscando un sistema para poder poner checkbox como estas:
    ;; - [ ] Sin marcar
    ;; - [X] Marcada

    ;; En las tablas, pero esto *no funciona* por lo menos de momento.
    (defun check-cell ()
      (interactive)
      (let ((cell (org-table-get-field)))
        (if (string-match "[[:graph:]]" cell)
            (org-table-blank-field)
          (insert "X")
          (org-table-align))
        (org-table-next-field)))

  (load! "org.agenda.config.el")
  (load! "org.calendario.config.el")
)

(load! "mu4e.config.el") ;; configuración de correo

(load! "flyspell.config.el") ;; configuración sobre corrector ortográfico

(load! "editor.config.el") ;; configuraciones sobre mostrar número de linea y esas cosas

(load! "keybinds.config.el") ;; configuraciones sobre mostrar número de linea y esas cosas
