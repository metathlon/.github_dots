;;; ~/.doom.d/nueva_config/org.babel.config.el -*- lexical-binding: t; -*-

;; ** Org-Babel
;; Al parecer =org-babel-do-load-languages= es redundante con emacs Doom, pero no
;; se cómo incluir R en los lenguajes que controla babel. Tendré que mirarlo.

;; #+BEGIN_SRC emacs-lisp
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))
;; #+END_SRC
