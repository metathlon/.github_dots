;;; ~/.doom.d/nueva_config/org.templates.config.el -*- lexical-binding: t; -*-

;; ** Org-Tempo
;; Cuando quieres usar snippets personalizados para código y usarlos como
;; =<s-<TAB>=... tienes que activar =org-tempo=

;; #+BEGIN_SRC emacs-lisp
    ;; TODO: esto no funciona del todo bien, habrá que revisar los trigger estos, creo que no lo estoy usando bien
    ;; (defun caronte/r-src-snippet )
(require 'org-tempo)
(after! org
    (add-to-list 'org-structure-template-alist '("r" . "src R :results output :session"))
)
;; #+END_SRC
