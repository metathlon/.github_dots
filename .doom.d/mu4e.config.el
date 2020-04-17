;=====================================================================================
;
; MU4E
;
;=====================================================================================

(require 'smtpmail)

(after! mu4e
  (defvar mu4e-main-mode-map
    (let ((map (make-sparse-keymap)))
      ;; (define-key map "b" 'mu4e-headers-search-bookmark)
      ;; (define-key map "B" 'mu4e-headers-search-bookmark-edit)

      ;; (define-key map "s" 'mu4e-headers-search)
      (define-key map "q" 'mu4e-quit)
      (define-key map "j" 'mu4e~headers-jump-to-maildir)
    )
  )

  ;;=============================================================================
  ;;              EJEMPLO de CONTEXTOS
  ;;==============================================================================
  ;; (setq mu4e-contexts
  ;;    `(
  ;;     ;;***************************************************************************************
  ;;     ;;                               CONTEXT: cuenta@gmail.com
  ;;     ;;--------------------------------------------------------------------------------------
  ;;     ;;Este contexto puede repetirse tantas veces como sea necesario, una vez por cuenta
  ;;     ;;***************************************************************************************
  ;;   ,(make-mu4e-context
  ;;     :name "cuenta_gmail"
  ;;     :match-func (lambda (msg)
  ;;         (when msg
  ;;             (mu4e-message-contact-field-matches msg
  ;;                 :to "cuenta@gmail.com")))
  ;;     :vars '(
  ;;         (mu4e-get-mail-command  . "mbsync -c ~/.mail/.mbsyncrc_cuenta -a")
  ;;         (user-mail-address      . "cuenta@gmail.com")
  ;;         (user-full-name         . "Nombres y apellidos")
  ;;         ;; ---- OJO a continuación se indican los directorios [cuenta_mail] debe ser el mismo directorio que especificaste en .mbsyncrc_cuenta para INBOX
  ;;         ;; En realidad no TIENE que ser el mismo pero tener el INBOX en un lado y los demás en otro... es raro
  ;;         ;; ----------------------------------------------------------------------------------------------------------
  ;;         (mu4e-drafts-folder     . "/cuenta_mail/DRAFTS")
  ;;         (mu4e-refile-folder     . "/cuenta_mail/ARCHIVE")
  ;;         (mu4e-sent-folder       . "/cuenta_mail/SENT")
  ;;         (mu4e-trash-folder      . "/cuenta_mail/DELETED")
  ;;       ) ;; VARS
  ;;     ) ;; CONTEXT
  ;;   ) ;; fin lista de contexts
  ;; ) ;;-----------------------------------------------------------------FIN DE CONTEXTS
  (load! "mu4e.personal.config.el")
) ;; ------------------------------------------------------------------------------------FIN  after! mu4e



;; ------------------------------------------------------------------------------
;; --------------- BASIC mail config
;; ------------------------------------------------------------------------------
(setq message-kill-buffer-on-exit t
      mu4e-attachment-dir              "~/Descargas/MU4E_ATTACHMENTS/"
      mail-user-agent 'mu4e-user-agent
      mu4e-index-update-in-background t
      mu4e-compose-signature-auto-include t
      mu4e-use-fancy-chars t
      mu4e-view-show-addresses t
      mu4e-view-show-images t
      mu4e-sent-messages-behavior 'sent
      ;; mu4e-compose-format-flowed t
      ;; mu4e-compose-in-new-frame t
)
(setq mail-user-agent 'mu4e-user-agent)
;; set `mu4e-context-policy` and `mu4e-compose-policy` to tweak when mu4e should
;; guess or ask the correct context, e.g.

;; start with the first (default) context;
;; default is to ask-if-none (ask when there's no context yet, and none match)
(setq mu4e-context-policy 'pick-first)

;; ------ SHORTCUTS PERSONALIZADOS--------------------------------------
;; Para que esto funcione tienes que haber definido antes car-map
;; En mi caso esto está hecho en config.el
;; Primero hay que borrar la tecla
;; Despues se asigna a 'car-map
;; Ahora ya puedes usarla como "prefijo"
;; ---------------------------------------------------------------------
;; (define-key car-map (kbd "c") 'mu4e-compose-new)
(define-key car-map (kbd "s") 'mu4e-headers-search)

(define-key mu4e-compose-mode-map (kbd "C-1 c") 'message-goto-cc)
(define-key mu4e-compose-mode-map (kbd "C-1 s") 'message-send-and-exit)
;; (define-key mu4e-org-mode-map (kbd "C-1 k") 'message-send-and-exit)

;------------------------------------------------------------------
;  CAPTURAR Correos para el ORG-MODE
;  ------------------------------------
;  C: capturar
;------------------------------------------------------------------
(defun caronte/org-capture-email ()
    (interactive)
    (org-capture nil "e"))
(define-key mu4e-headers-mode-map (kbd "c") 'caronte/org-capture-email)



;------------------------------------------------------------------
;  MANDAR CORREOS CON HTML y/o ARCHIVOS
;  ------------------------------------
;  Es un problema lo del HTML y lo de los archivos, antes de hacer esto
;  tenía que montar un follón, ahora solo he instaldo org-msg y usas
;  los comandos normales de tu gestor de correo y las cosas pasan
;  C-c C-c: enviar
;  C-c C-a: attach
;------------------------------------------------------------------
(require 'org-msg)
(setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil"
      org-msg-startup "hidestars indent inlineimages"
      org-msg-greeting-fmt "\nHola %s,\n\n"
      org-msg-greeting-name-limit 3
      org-msg-text-plain-alternative t
      org-msg-signature caronte/org-msg-signature
      ;; org-msg-signature "

      ;; Un saludo,

      ;; #+begin_signature
      ;;  /No me imprimas si no es estrictamente imprescindible/
      ;; #+end_signature"
)
(org-msg-mode)

;------------------------------------------------------------------
;  MANDAR CORREOS CON HTML y/o ARCHIVOS
;  ------------------------------------
;  Esta es la configuración anterior y funcionaba pero regular
;------------------------------------------------------------------
(setq mu4e-html2text-command 'mu4e-shr2text)


;; mu4e toggle html images
(defvar killdash9/mu4e~view-html-images nil
  "Whether to show images in html messages")

(defun killdash9/mu4e-view-toggle-html-images ()
  "Toggle image-display of html message."
  (interactive)
  (setq-local killdash9/mu4e~view-html-images (not killdash9/mu4e~view-html-images))
  (message "Images are %s" (if killdash9/mu4e~view-html-images "on" "off"))
  (mu4e-view-refresh))

(defun mu4e-shr2text (msg)
  "Convert html in MSG to text using the shr engine; this can be
used in `mu4e-html2text-command' in a new enough emacs. Based on
code by Titus von der Malsburg."
  (lexical-let ((view-images killdash9/mu4e~view-html-images))
    (mu4e~html2text-wrapper
      (lambda ()
      (let ((shr-inhibit-images (not view-images)))
        (shr-render-region (point-min) (point-max)))) msg)))

(define-key mu4e-view-mode-map "i" 'killdash9/mu4e-view-toggle-html-images)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))


;; (setq mu4e-html2text-command "html2text -utf8 -width 72") ;; nil "Shel command that converts HTML
;; ;; ref: http://emacs.stackexchange.com/questions/3051/how-can-i-use-eww-as-a-renderer-for-mu4e
;; (defun my-render-html-message ()
;;   (let ((dom (libxml-parse-html-region (point-min) (point-max))))
;;     (erase-buffer)
;;     (shr-insert-document dom)
;;     (goto-char (point-min))))
;; (setq mu4e-html2text-command 'my-render-html-message)

;; ;; yt
;; (setq mu4e-view-prefer-html t) ;; try to render
;; (add-to-list 'mu4e-view-actions
;;              '("ViewInBrowser" . mu4e-action-view-in-browser) t) ;; read in browser
;; (require 'org-mu4e)
;;                                         ;; == M-x org-mu4e-compose-org-mode==
;; (setq org-mu4e-convert-to-html t) ;; org -> html
                                        ;; = M-m C-c.=






;; ;; https://matt.hackinghistory.ca/2016/11/18/sending-html-mail-with-mu4e/
;; ;; this is stolen from John but it didn't work for me until I
;; ;; made those changes to mu4e-compose.el
;; (defun htmlize-and-send ()
;;   "When in an org-mu4e-compose-org-mode message, htmlize and send it."
;;   (interactive)
;;   (when (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
;;     (org-mime-htmlize)
;;     (org-mu4e-compose-org-mode)
;;     (mu4e-compose-mode)
;;     (message-send-and-exit)))

;; ;; This overloads the amazing C-c C-c commands in org-mode with one more function
;; ;; namely the htmlize-and-send, above.
;; (add-hook 'org-ctrl-c-ctrl-c-hook 'htmlize-and-send t)

;; ;; Originally, I set the `mu4e-compose-mode-hook' here, but
;; ;; this new hook works much, much better for me.
;; (add-hook 'mu4e-compose-post-hook
;;           (defun do-compose-stuff ()
;;             "My settings for message composition."
;;             (org-mu4e-compose-org-mode)))


;;===========================================================================
;;---------------------------------------------------------------------------
;;      EMAIL ALERTS
;;---------------------------------------------------------------------------
;;===========================================================================
;; Este es un ejemplo de como manejar las alertas
;; Yo voy a poner mi configuración en el archivo privado pero simplemente
;; hay que adaptar las carpetas y todo irá bien
(setq mu4e-alert-interesting-mail-query
    (concat
     "flag:unread maildir:/Exchange/INBOX "
     "OR "
     "flag:unread maildir:/Gmail/INBOX"
     ))
(mu4e-alert-enable-mode-line-display)
(defun caronte-refresh-mu4e-alert-mode-line ()
  (interactive)
  (mu4e~proc-kill)
  (mu4e-alert-enable-mode-line-display)
  )
(run-with-timer 0 60 'caronte-refresh-mu4e-alert-mode-line)
