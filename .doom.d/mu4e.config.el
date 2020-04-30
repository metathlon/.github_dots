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
      ;; org-msg-signature caronte/org-msg-signature

)
;;================================================
;;              FIRMAS
;;===============================================
;; Lo de las firmas tiene su complicación cuando tienes varias cuentas
;; Especialmente si quieres una firma HTML
;;
;; En mi caso en la parte corporativa NECESITABA poner la firma html
;; así que aquí dejo dos ejemplos de cómo quedaría esto en mu4e.personal.config.el
;;---------------------------
;; NO HTML
;;---------------------------------
;; (setq caronte/org-msg-signature "
;;     Un saludo,
;;     #+begin_signature
;;        /No me imprimas si no es estrictamente imprescindible/
;;     #+end_signature")
;;
;;--------------------------------------
;; FIRMA HTML
;;-------------------------------------
;; (setq caronte/org-msg-signature "
;;          #+BEGIN_EXPORT html
;;             <html>
;;              <table width='100%' border='0' cellspacing='10' cellpadding='0' style='color: rgb(0, 0, 0);border-top-width: 3px; border-top-style: solid; border-top-color: rgb(162, 195, 227);'>
;;               <tbody>
;;                 <tr>
;;                   <td><br></td>
;;                   <td></td>
;;                </tr>
;;                <tr>
;;                   <td width='200' align='right' valign='top'> <img src='URL.png' alt='TEXTO_ALTERNATIVO' hspace='5'> </td>
;;                   <td align='left' valign='top' style='padding: 10px;'>
;;                      <p><font face='Arial, Helvetica, sans-serif' color='#05233d' style='font-size: 18px;'>NOMBRE</font><br>
;;                         <font face='Arial, Helvetica, sans-serif' color='#90a7b5'><em style='font-size: 12px;'>TITULO</em></font><br>
;;                         <a href='mailto:CORREO' style='color: rgb(0, 153, 204); text-decoration: none;'>CORREO</a>&nbsp;<br>
;;                      </p>
;;                      <p><font face='Arial, Helvetica, sans-serif' color='#05233d' style='font-size: 14px;'>SITIO_DE_TRABAJO</font>
;;                         <br><font face='Arial, Helvetica, sans-serif' color='#05233d' style='font-size: 14px;'><a target='_blank' class='blue' href='http://URL_EMPRESA' style='color: rgb(0, 153, 204); text-decoration: none;'>http://URL_PROFESIONAL</a></font>
;;                         <br><font face='Arial, Helvetica, sans-serif' color='#416886' size='-1'>Tlf:&nbsp;<strong><font color='#1b4260'>TELEFONO</font></strong><font face='Arial, Helvetica, sans-serif' color='#1b4260' size='-1'></font></font>
;;                      </p>
;;                   </td>
;;                </tr>
;;               </tbody>
;;              </table>
;;             </html>
;;        #+END_EXPORT
;; " )

(org-msg-mode)

;------------------------------------------------------------------
;  MANDAR CORREOS CON HTML y/o ARCHIVOS
;  ------------------------------------
;  Esta es la configuración anterior y funcionaba pero regular
;------------------------------------------------------------------
(setq mu4e-html2text-command 'mu4e-shr2text)


;; mu4e toggle html images
;; (defvar killdash9/mu4e~view-html-images nil
;;   "Whether to show images in html messages")
(defvar killdash9/mu4e~view-html-images t
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




;;===========================================================================
;;---------------------------------------------------------------------------
;;     Contactos correo
;;---------------------------------------------------------------------------
;;===========================================================================
(setq mu4e-org-contacts-file org-contact-files)
(add-to-list 'mu4e-headers-actions
  '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
  '("org-contact-add" . mu4e-action-add-org-contact) t)


;;===========================================================================
;;---------------------------------------------------------------------------
;;      EMAIL ALERTS
;;---------------------------------------------------------------------------
;;===========================================================================
;; Este es un ejemplo de como manejar las alertas
;; Yo voy a poner mi configuración en el archivo privado pero simplemente
;; hay que adaptar las carpetas y todo irá bien
;;---------------------------------------------------------------------------
;; (setq mu4e-alert-interesting-mail-query
;;     (concat
;;      "flag:unread maildir:/Exchange/INBOX "
;;      "OR "
;;      "flag:unread maildir:/Gmail/INBOX"
;;      ))
;; (mu4e-alert-enable-mode-line-display)
;; (defun caronte-refresh-mu4e-alert-mode-line ()
;;   (interactive)
;;   (mu4e~proc-kill)
;;   (mu4e-alert-enable-mode-line-display)
;;   )
;; (run-with-timer 0 60 'caronte-refresh-mu4e-alert-mode-line)
