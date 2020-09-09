;;; ~/.doom.d/nueva_config/org.files.config.el -*- lexical-binding: t; -*-

(setq caronte/org-agenda-directory (concat caronte/org-directory "ACTIVOS/"))
(setq caronte/org-agenda-FILE-tareas (concat caronte/org-agenda-directory "TAREAS.org"))
(setq caronte/org-agenda-FILE-links (concat caronte/org-agenda-directory "LINKS.org"))
(setq caronte/org-agenda-FILE-emails (concat caronte/org-agenda-directory "EMAILS.org"))
(setq caronte/org-agenda-FILE-recetas (concat caronte/org-agenda-directory "RECETAS.org"))
(setq caronte/org-agenda-FILE-calendario-personal (concat caronte/org-agenda-directory "GCAL_ORG_MODE_events_inbox.org"))
(setq caronte/org-agenda-FILE-calendario-trabajo (concat caronte/org-agenda-directory "GCAL_trabajo_events_inbox.org"))
(setq caronte/org-agenda-FILE-calendario-personal-gmail (concat caronte/org-agenda-directory "GCAL_personal_gmail_events_inbox.org"))
(setq caronte/org-agenda-FILE-calendario-festivos-gmail (concat caronte/org-agenda-directory "GCAL_festivos_inbox.org"))
(setq caronte/org-agenda-FILE-contactos (concat caronte/org-agenda-directory "CONTACTOS.org"))

;; -- OTROS DOCUMENTOS
(setq caronte/org-documentos-directory (concat caronte/org-directory "DOCUMENTOS/"))
(setq caronte/org-documentos-FILE-estadistica (concat caronte/org-documentos-directory "ESTADISTICA.org"))
(setq caronte/org-documentos-FILE-estudios (concat caronte/org-documentos-directory "DISEÑO_ESTUDIOS.org"))
;; *** C-2 car-org-map
;; **** Funciones
;; Si hacemos el bind directamente al archivo cuando presionamos C-2 lo que aparece
;; es:
;; 1 - lambda
;; 2 - lambda
;; a - lambda

;; Como esto es muy poco descriptivo usamos funciones de forma que lo que aparece
;; es:
;; 1 - caronte/open-file-CONFIG
;; t - caronte/open-file-TAREAS

;; que es mucho más descriptivo

(defun caronte/open-file-CONFIG()
  (interactive)
  (find-file "~/.doom.d/config.org")
)
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
  (find-file caronte/org-documentos-FILE-estadistica)
)
(defun caronte/open-file-ESTUDIOS()
  (interactive)
  (find-file caronte/org-documentos-FILE-estudios)
)
;; ------------- CONTACTOS ---
(defun caronte/open-file-CONTACTOS()
  (interactive)
  (find-file caronte/org-contacts-FILE)
)
