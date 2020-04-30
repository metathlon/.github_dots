;;; ~/.doom.d/org-contacts.conf.el -*- lexical-binding: t; -*-

;; -- lo primero es cargar el archivo de contacts
;; -- En este punto org.config.el así que generamos el archivo de contactos

(setq caronte/org-contacts-FILE (concat caronte/org-agenda-directory "CONTACTOS.org"))
(setq caronte/org-imported-contacts-FILE (concat caronte/org-agenda-directory "CONTACTOS-IMPORTADOS.org"))


(defun caronte/open-file-CONTACTOS()
  (interactive)
  (find-file caronte/org-contacts-FILE)
)

(define-key car-org-map (kbd "c") 'caronte/open-file-CONTACTOS)


(setq org-contact-files '(caronte/org-contacts-FILE caronte/org-imported-contacts-FILE))

;; -- los templates tb deberían estar cargados así que
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
                  :END:\n"             )
             )

