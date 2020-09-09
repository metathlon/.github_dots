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
