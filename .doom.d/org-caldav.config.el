;; =============================================================================================
;;  CONFIGURACION de org-caldav
;;  --------------------------------------------------------------------------------------------
;;  Gran parte de esta configuración se basa en la encontrada en:
;;  https://www.reddit.com/r/orgmode/comments/8rl8ep/making_orgcaldav_useable/
;; =============================================================================================

;; This is the sync on close function; it also prompts for save after syncing so
;; no late changes get lost
(defun org-caldav-sync-at-close ()
  (org-caldav-sync)
  (save-some-buffers))

;; This is the delayed sync function; it waits until emacs has been idle for
;; "secs" seconds before syncing.  The delay is important because the caldav-sync
;; can take five or ten seconds, which would be painful if it did that right at save.
;; This way it just waits until you've been idle for a while to avoid disturbing
;; the user.
(defvar org-caldav-sync-timer nil
    "Timer that `org-caldav-push-timer' used to reschedule itself, or nil.")
(defun org-caldav-sync-with-delay (secs)
  (when org-caldav-sync-timer
    (cancel-timer org-caldav-sync-timer))
  (setq org-caldav-sync-timer
  (run-with-idle-timer
    (* 1 secs) nil 'org-caldav-sync)))

(setq org-icalendar-alarm-time 1)
;; This makes sure to-do items as a category can show up on the calendar
(setq org-icalendar-include-todo t)
;; This ensures all org "deadlines" show up, and show up as due dates
(setq org-icalendar-use-deadline '(event-if-todo event-if-not-todo todo-due))
;; This ensures "scheduled" org items show up, and show up as start times
(setq org-icalendar-use-scheduled '(todo-start event-if-todo event-if-not-todo))
;; Add the delayed save hook with a five minute idle timer
(add-hook 'after-save-hook
    (lambda ()
      (when (eq major-mode 'org-mode)
  (org-caldav-sync-with-delay 300))))
;; Add the close emacs hook
;; (add-hook 'kill-emacs-hook 'org-caldav-sync-at-close)



;; ----------------------------------------------------------------------------------
;; CONFIGURACION PERSONAL, MODIFICAR ADECUADAMENTE
;; ----------------------------------------------------------------------------------
;; Esta configuración la he puesto en un archivo a parte "org-calendar.personal.config.el"
;; de esta forma puedo subir este archivo a github y que se use sin tener información sensible
;;
;; Lo unico que tiene "org-caldav-persona.config.el" son estas lineas con la información pertinente
;; OJO, puedes añadir más calendarios, esto es solo un ejemplo. Para cualquier duda consultar
;; la documentacion en: https://github.com/dengste/org-caldav
;; ----------------------------------------------------------------------------------
;; (setq org-caldav-oauth2-client-id "xxxxxxxxxxxx" )
;; (setq org-caldav-oauth2-client-secret "xxxxxxxxxx")
;; (setq org-caldav-url 'google)
;; (setq org-caldav-calendars
;;     '((:calendar-id "xxxxxxxxxxxxxxxxxx@group.calendar.google.com"
;;                     :files ("~/ORG/ORG_CALENDAR/test1_events.org")
;;                     :inbox "~/ORG_CALENDAR/test1_events.org"

;;         ))
;; )


(load! "org-caldav.personal.config.el")
