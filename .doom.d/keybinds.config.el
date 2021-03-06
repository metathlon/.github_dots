;;; ~/.doom.d/nueva_config/keybinds.config.el -*- lexical-binding: t; -*-

;; * Keybindings
;; ** Globales
;; *** Org-Capture
(global-set-key "\C-cc" 'org-capture)


;; ** Grupos de acceso rápido personales
;; *** Setup
;; **** Limpiando de C-0 a C9
;; Lo primero es liberar algunas combianciones de teclas. He decidido hacer de C-1,
;; C-2, ... mis accesos rápidos. Así que limpiemos esas combinaciones de teclas
;; desde C-0 a C-9

;; ==========================================================================
;; --------- Configuracion  de shortcuts personales --------------------------
;; ==========================================================================
;; lo primero es borrar las combiaciones C-1, C-2...
(dotimes (n 10)
  (global-unset-key (kbd (format "C-%d" n)))
  (global-unset-key (kbd (format "M-%d" n)))
)

;; **** Creando prefijos
;; Para poder usar estas combinaciones debemos crear un prefijo. Este es
;; básicamente el nombre del mapa de teclas asociado a ese grupo, por ejemplo, C-1
;; será car-map (un grupo genérico para lanzar aplicaciones) y C-2 será
;; car-org-map, un grupo para abrir directamente algunos archivos ORG de acceso habitual.

;; ;; ahora que tenemos "hueco" vamos a hacer nuestro propio mapa de atajos
(define-prefix-command 'car-map)
(global-set-key (kbd "C-1") 'car-map)
(define-prefix-command 'car-org-map)
(global-set-key (kbd "C-2") 'car-org-map)
;; estos atajos los voy a usar en otras partes, como el correo, la agenda, sitios así

;; *** C-1 car-map

;; **** Teclas
;; -------------- AGENDA
(define-key car-map (kbd "a") 'org-agenda-custom-view )

;; -------------- NEOTREE
(define-key car-map (kbd "n") 'neotree)

;; -------------- CALENDAR
(define-key car-map (kbd "c") 'caronte/open-calendar)
    ;; (define-key car-map (kbd "s") 'org-caldav-sync)

;; -------------- MU4E
(define-key car-map (kbd "m") 'mu4e)
;; (define-key car-map (kbd "s") 'mu4e-headers-search)
(define-key mu4e-compose-mode-map (kbd "C-1 c") 'message-goto-cc)
(define-key mu4e-compose-mode-map (kbd "C-1 s") 'message-send-and-exit)


;; #+RESULTS:
;; : message-send-and-exit




;; **** Teclas
;; #+BEGIN_SRC emacs-lisp
(define-key car-org-map (kbd "1") 'caronte/open-file-CONFIG)
(define-key car-org-map (kbd "t") 'caronte/open-file-TAREAS)
(define-key car-org-map (kbd "l") 'caronte/open-file-LINKS)
(define-key car-org-map (kbd "e") 'caronte/open-file-EMAILS)
(define-key car-org-map (kbd "r") 'caronte/open-file-RECETAS)
;; (define-key car-org-map (kbd "c") 'caronte/open-file-CALENDARIO-PERSONAL)
;; (define-key car-org-map (kbd "C") 'caronte/open-file-CALENDARIO-TRABAJO)
(define-key car-org-map (kbd "E") 'caronte/open-file-ESTADISTICA)
(define-key car-org-map (kbd "d") 'caronte/open-file-ESTUDIOS)
;; ------------------------- CONTACTOS----------
(define-key car-org-map (kbd "c") 'caronte/open-file-CONTACTOS)
;; #+END_SRC
