;;; ~/.doom.d/nueva_config/editor.config.el -*- lexical-binding: t; -*-

;; * Editor
;; ** Número de linea
;; #+BEGIN_SRC emacs-lisp
(setq display-line-numbers-type t)
;; #+END_SRC
;; ** Área seleccionada
;; En emacs por defecto cuando resaltas un área con el editor en modo visual, ese
;; área se queda marcada a la espera de que hagas algo con ella. Pero no es eso lo
;; que pasa en los editores normalmente. Normalmente marcas un área y haces algo, o
;; no, y si escribes en otra parte del documento esa selección se pierde.

;; Este es un comportamiento al que ya estoy muy hecho y por lo tanto lo prefiero
;; en emacs también:

;; #+BEGIN_SRC emacs-lisp
(use-package delsel
  :disabled
  :ensure nil
  :config (delete-selection-mode +1))
;; #+END_SRC

;; #+BEGIN_SRC emacs-lisp
(setq delete-selection-mode t)
;; #+END_SRC

;; ** Disable scroll bar
;; Usamos las teclas para todo, no es como que vaya a darle con el ratón a la barra
;; de scroll, así que lo mejor es quitarla.

;; #+BEGIN_SRC emacs-lisp
(use-package scroll-bar
  :defer t
  :ensure nil
  :config (scroll-bar-mode -1))
;; #+END_SRC

;; ** Confirm kill process
;; Hay varios paquetes que generan /procesos/ dentro de emacs (como python, la
;; sincronización de calendario, etc etc etc). Cuando cierras si alguno de estos
;; procesos está activo te pide confirmación. No quiero tener que confirmar 100
;; cosas cuando cierro el programa.

;; #+BEGIN_SRC emacs-lisp
(use-package files
  :defer t
  :config
  (setq confirm-kill-processes nil))
;; #+END_SRC

;; ** Actualización de cambios externos en archivos
;; No es raro que yo edite cosas en varios sitios al mismo tiempo, con varias
;; sesiones de emacs, con vim, con lo que sea. El caso es que quiero que cuando
;; cambie algo fuera, si tengo ya abierto el archivo en un buffer, ese buffer se
;; actualice con el estado actual del fichero.

;; #+BEGIN_EXPORT emacs-lisp
(use-package autorevert
  :defer t
  :ensure nil
  :config
  (global-auto-revert-mode +1)
  (setq auto-revert-interval 2
        auto-revert-check-vc-info t
        auto-revert-verbose nil))
;; #+END_EXPORT

;; ** Marcado de paréntesis

;; Por defecto tiene cierto retraso, creo que es para que no haya marcas volando
;; por ahí cuando mueves el cursor por el texto. Como fuere quiero que la marca de
;; paréntesis sea instantánea si es posible.
;; #+BEGIN_SRC emacs-lisp
(use-package paren
  :defer t
  :ensure nil
  :init (setq show-paren-delay 0.5)
  :config (show-paren-mode +1))
;; #+END_SRC

;; ** Incluir guión bajo como parte de la palabra
;; Al contrario de vim, emacs trata cada parte de una palabra con guiones bajos (_)
;; como una palabra (al darle a w por ejemplo). Esto tiene sus cosas buenas y
;; malas, no estoy seguro de si quiero quitarlo pero por si acaso voy a dejar aquí
;; el código para hacerlo.

;; #+BEGIN_SRC emacs-lisp
;; ;; (add-hook 'after-change-major-mode-hook
;; ;;           (lambda ()
;; ;;             (modify-syntax-entry ?_ "w")))
;; #+END_SRC

;; ** Histórico
;; Control del histórico y limpieza del mismo

;; #+BEGIN_SRC emacs-lisp
(use-package recentf
  :defer t
  :ensure nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-auto-cleanup "05:00am")
  (recentf-max-saved-items 200)
  (recentf-exclude '((expand-file-name package-user-dir)
                     ".cache"
                     ".cask"
                     ".elfeed"
                     "bookmarks"
                     "cache"
                     "ido.*"
                     "persp-confs"
                     "recentf"
                     "undo-tree-hist"
                     "url"
                     "COMMIT_EDITMSG\\'")))

;; When buffer is closed, saves the cursor location
(save-place-mode 1)

;; Set history-length longer
(setq-default history-length 500)
;; #+END_SRC
