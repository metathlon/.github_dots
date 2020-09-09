;;; ~/.doom.d/nueva_config/org.contacts.config.el -*- lexical-binding: t; -*-

;; *** Variables
;; Definición de variables básicas

;; #+BEGIN_SRC emacs-lisp
;; (after! org
    (setq caronte/org-contacts-FILE (concat caronte/org-agenda-directory "CONTACTOS.org"))
    (setq caronte/org-imported-contacts-FILE (concat caronte/org-agenda-directory "CONTACTOS-IMPORTADOS.org"))
    (setq org-contact-files '(caronte/org-contacts-FILE))
;; )
;; #+END_SRC
;; *** Template de captura
;; #+BEGIN_SRC emacs-lisp
;; (after! org
    (add-to-list 'org-capture-templates
             '("C" "Contacto" entry (file caronte/org-contacts-FILE)
                  "* %^{Nombre}
                  :PROPERTIES:
                  :ADDRESS: %^{Direccion}
                  :BIRTHDAY: %^{yyyy-mm-dd}
                  :EMAIL: %^{correo}
                  :PHONE: %^{Telefono}
                  :NOTE: %^{NOTE}
                  :TAGS: %^{Relacion: | :familia | :amigo | :conocido | :trabajo }
                  :NICK: %^{NICK}
                  :END:
               ")
     )
;; )
;; #+END_SRC
