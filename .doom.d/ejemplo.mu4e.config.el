;=====================================================================================
;
; MU4E
;
;=====================================================================================


(after! mu4e

  ;; --------------------------------------------- BASIC mail config
  (setq message-kill-buffer-on-exit t
        mu4e-attachment-dir              "~/Descargas/MU4E_ATTACHMENTS/"
        mail-user-agent 'mu4e-user-agent
        ;; mu4e-maildir-shortcuts
        ;;    '( ("/INBOX" ?i)
        ;;       ("/ARCHIVE" ?a)
        ;;       ("/DRAFTS" ?d)
        ;;       ("/DELETED" ?t)
        ;;       ("/SENT" ?s))
        mu4e-index-update-in-background t
        mu4e-compose-signature-auto-include t
        mu4e-use-fancy-chars t
        mu4e-view-show-addresses t
        mu4e-view-show-images t
        mu4e-compose-format-flowed t
        ;mu4e-compose-in-new-frame t
  )

  ;;-----------------------------------------------CONTEXTS
  (setq mu4e-contexts

        `(
      ;;***************************************************************************************
      ;;                               CONTEXT: cuenta@gmail.com
      ;;--------------------------------------------------------------------------------------
      ;;Este contexto puede repetirse tantas veces como sea necesario, una vez por cuenta
      ;;***************************************************************************************
    ,(make-mu4e-context
      :name "cuenta_gmail"
      :match-func (lambda (msg)
          (when msg
              (mu4e-message-contact-field-matches msg
                  :to "cuenta@gmail.com")))
      :vars '(
          (mu4e-get-mail-command  . "mbsync -c ~/.mail/.mbsyncrc_cuenta -a")
          (user-mail-address      . "cuenta@gmail.com")
          (user-full-name         . "Nombres y apellidos")
          ;; ---- OJO a continuación se indican los directorios [cuenta_mail] debe ser el mismo directorio que especificaste en .mbsyncrc_cuenta para INBOX
          ;; En realidad no TIENE que ser el mismo pero tener el INBOX en un lado y los demás en otro... es raro
          ;; ----------------------------------------------------------------------------------------------------------
          (mu4e-drafts-folder     . "/cuenta_mail/DRAFTS")
          (mu4e-refile-folder     . "/cuenta_mail/ARCHIVE")
          (mu4e-sent-folder       . "/cuenta_mail/SENT")
          (mu4e-trash-folder      . "/cuenta_mail/DELETED")
        ) ;; VARS
      ) ;; CONTEXT

    ) ;; fin lista de contexts
  ) ;;-----------------------------------------------------------------FIN DE CONTEXTS

  ;; set `mu4e-context-policy` and `mu4e-compose-policy` to tweak when mu4e should
  ;; guess or ask the correct context, e.g.

  ;; start with the first (default) context;
  ;; default is to ask-if-none (ask when there's no context yet, and none match)
  (setq mu4e-context-policy 'pick-first)

  ;; compose with the current context is no context matches;
  ;; default is to ask
  ;; (setq mu4e-compose-context-policy nil)

) ;; ------------------------------------------------------------------------------------FIN  after! mu4e
;; Bookmarks for common searches that I use.
(setq mu4e-bookmarks '(   ("\\\\Inbox" "Inbox" ?i)
                          ("flag:unread" "Unread messages" ?u)
                          ("date:today..now" "Today's messages" ?t)
                          ("date:7d..now" "Last 7 days" ?w)
                          ("mime:image/*" "Messages with images" ?p)))
