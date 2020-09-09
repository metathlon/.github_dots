;; ;;; ~/.doom.d/nueva_config/mu4e.config.el -*- lexical-binding: t; -*-

;; * Mu4e
;; Mucha de la configuración del correo implica datos personales, para evitar
;; subirlos he separado la configuración entre /genérica/ y /personal/.
;; ** Base

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
    (load! "mu4e.personal.config.el")
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
)


;; ==========================================================================
;; --------- configuracion de correo ----------------------------------------
;; ==========================================================================
;; La configuracion del coreo se ha pasado a mu4e.config para "anonimizar"
;; En este directorio se puede encotrar un ejemplo de la configuracion:
;; ejemplo.mu4e.config.el
;; -------------------------------------------------------------------------
;; PARA ARREGLAR EL MENU PRINCIPAL
(remove-hook 'mu4e-main-mode-hook 'evil-collection-mu4e-update-main-view)


;; Cargamos nuestra configuración particular
;; (load! "mu4e.config.el")
;; (define-key car-map (kbd "m") 'mu4e)
;; Creo que esto solucionará el que se active el org-mu4e-compose-org-mode
(remove-hook 'mu4e-compose-mode-hook 'org-mu4e-compose-org-mode)



;; ** Contextos
;; Como tengo configuradas multiples cuentas uso contextos (ver ejemplo de
;; configuración personal), por esto tengo que indicar qué contexto será el
;; /default/
(after! mu4e
  (setq mu4e-context-policy 'pick-first)
)

;; ** Capturar correo con org-mode
(defun caronte/org-capture-email ()
    (interactive)
    (org-capture nil "e"))
(define-key mu4e-headers-mode-map (kbd "c") 'caronte/org-capture-email)

;; ** Mandar correos con HTML o archivos
;; *** Org-msg
;; Es un problema lo del HTML y lo de los archivos, antes de hacer esto tenía que
;; montar un follón, ahora solo he instalado [[github:https://github.com/jeremy-compostella/org-msg][org-msg]] y usas los comandos normales de
;; tu gestor de correo y las cosas pasan

;; C-c C-c: enviar
;; C-c C-a: attach
(require 'org-msg)
(after! org
    (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil"
        org-msg-startup "hidestars indent inlineimages"
        org-msg-greeting-fmt "\nHola %s,\n\n"
        org-msg-greeting-name-limit 1
        org-msg-text-plain-alternative t
        ;; org-msg-signature caronte/org-msg-signature
    )
)

(org-msg-mode)

;; *** Renderizar correos con HTML
(setq mu4e-html2text-command 'mu4e-shr2text)
(defvar caronte/mu4e~view-html-images t
  "Intentar mostrar imágenes en mensaje HTML")

(defun caronte/mu4e-view-toggle-html-images ()
  "Toggle el ver imágenes en el HTML."
  (interactive)
  (setq-local caronte/mu4e~view-html-images (not caronte/mu4e~view-html-images))
  (message "Images are %s" (if caronte/mu4e~view-html-images "on" "off"))
  (mu4e-view-refresh))


(defun mu4e-shr2text (msg)
  "Transformar el codigo HTML del mensaje a texto usando el motor shr;
   Esto es lo que usaremos para configurar `mu4e-html2text-command'.
   Based on code by Titus von der Malsburg."

  (lexical-let ((view-images caronte/mu4e~view-html-images))
    (mu4e~html2text-wrapper
      (lambda ()
      (let ((shr-inhibit-images (not view-images)))
        (shr-render-region (point-min) (point-max)))) msg)))

(define-key mu4e-view-mode-map "i" 'caronte/mu4e-view-toggle-html-images)
(setq mu4e-html2text-command 'mu4e-shr2text)


;; ** Imágenes en los mensajes
;; Activarlas o no
(setq mu4e-view-show-images t)

;; Si imagemagick está instalado usarlo para mostrarla
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))


;; ** Alertas
;; Tengo que pensar cómo hacerlo de momento he cogido este código de algún sitio,
;; pero no lo veo claro

;; ;; (setq mu4e-alert-interesting-mail-query
;; ;;     (concat
;; ;;      "flag:unread maildir:/Exchange/INBOX "
;; ;;      "OR "
;; ;;      "flag:unread maildir:/Gmail/INBOX"
;; ;;      ))
;; ;; (mu4e-alert-enable-mode-line-display)
;; ;; (defun caronte-refresh-mu4e-alert-mode-line ()
;; ;;   (interactive)
;; ;;   (mu4e~proc-kill)
;; ;;   (mu4e-alert-enable-mode-line-display)
;; ;;   )
;; ;; (run-with-timer 0 60 'caronte-refresh-mu4e-alert-mode-line)


;; ** Ejemplo de configuración personal
;; en este mismo repositorio hay un archivo que se llama =ejemplo.mu4e.config.el=
;; que muestra un ejemplo de cómo sería la configuración "personal"

;; ** Contactos
;;===========================================================================
;;---------------------------------------------------------------------------
;;     Contactos correo
;;---------------------------------------------------------------------------
;;===========================================================================
(setq mu4e-org-contacts-file caronte/org-contacts-FILE)
(add-to-list 'mu4e-headers-actions
  '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
  '("org-contact-add" . mu4e-action-add-org-contact) t)

;; ;;need this for hash access
;; (require 'subr-x)

;; ;;my favourite contacts - these will be put at front of list
;; (setq bjm/contact-file (concat caronte/org-agenda-directory "CONTACTOS.txt"))

;; (defun bjm/read-contact-list ()
;;   "Return a list of email addresses"
;;   (with-temp-buffer
;;     (insert-file-contents bjm/contact-file)
;;     (split-string (buffer-string) "\n" t)))

;; ;; code from https://github.com/abo-abo/swiper/issues/596
;; (defun bjm/counsel-email-action (contact)
;;   (with-ivy-window
;;     (insert contact)))

;; ;; bind comma to launch new search
;; (defvar bjm/counsel-email-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map "," 'bjm/counsel-email-more)
;;     map))

;; (defun bjm/counsel-email-more ()
;;   "Insert email address and prompt for another."
;;   (interactive)
;;   (ivy-call)
;;   (with-ivy-window
;;     (insert ", "))
;;   (delete-minibuffer-contents)
;;   (setq ivy-text ""))

;; ;; ivy contacts
;; ;; based on http://kitchingroup.cheme.cmu.edu/blog/2015/03/14/A-helm-mu4e-contact-selector/
;; (defun bjm/ivy-select-and-insert-contact (&optional start)
;;   (interactive)
;;   ;; make sure mu4e contacts list is updated - I was having
;;   ;; intermittent problems that this was empty but couldn't see why
;;   (mu4e~contacts)
;;   (let ((eoh ;; end-of-headers
;;          (save-excursion
;;            (goto-char (point-min))
;;            (search-forward-regexp mail-header-separator nil t)))
;;         ;; append full sorted contacts list to favourites and delete duplicates
;;         (contacts-list
;;          (delq nil (delete-dups (append (bjm/read-contact-list) (hash-table-keys mu4e~contacts))))))

;;     ;; only run if we are in the headers section
;;     (when (and eoh (> eoh (point)) (mail-abbrev-in-expansion-header-p))
;;       (let* ((end (point))
;;            (start
;;             (or start
;;                 (save-excursion
;;                   (re-search-backward "\\(\\`\\|[\n:,]\\)[ \t]*")
;;                   (goto-char (match-end 0))
;;                   (point))))
;;            (initial-input (buffer-substring-no-properties start end)))

;;       (delete-region start end)

;;       (ivy-read "Contact: "
;;                 contacts-list
;;                 :re-builder #'ivy--regex
;;                 :sort nil
;;                 :initial-input initial-input
;;                 :action 'bjm/counsel-email-action
;;                 :keymap bjm/counsel-email-map)
;;       ))))

;; ;; ======================= USAR BBDB ==================================================
;; ;; FUNCIONA
;; ;; --------
;; ;; Para importar contactos desde csv -> M-x bbdb-csv-import y seleccionas el archivo
;; ;;=====================================================================================


  ;; Load BBDB (Method 1)
  ;; (require 'bbdb-loaddefs)
  ;; OR (Method 2)
  ;; (require 'bbdb-loaddefs "/path/to/bbdb/lisp/bbdb-loaddefs.el")
  ;; OR (Method 3)
  ;; (autoload 'bbdb-insinuate-mu4e "bbdb-mu4e")
  ;; (bbdb-initialize 'message 'mu4e)

  ;; (setq bbdb-mail-user-agent 'mu4e-user-agent)
  ;; (setq mu4e-view-mode-hook 'bbdb-mua-auto-update)
  ;; (setq mu4e-compose-complete-addresses nil)
  ;; (setq bbdb-mua-pop-up t)
  ;; (setq bbdb-mua-pop-up-window-size 5)
  ;; (setq mu4e-view-show-addresses t)








;; (use-package bbdb
;;   :ensure t
;;   :after mu4e
;;   :config
;;   ;; (require 'bbdb-loaddefs)
;;   (autoload 'bbdb-insinuate-mu4e "bbdb-mu4e")
;;   (bbdb-initialize 'message 'mu4e)
;;   (setq bbdb-file (concat org-directory "/bbdb")
;;         bbdb-mail-user-agent 'message-user-agent
;;         mu4e-view-mode-hook '(bbdb-mua-auto-update visual-line-mode)
;;         mu4e-compose-complete-addresses nil
;;         bbdb-mua-pop-up t
;;         bbdb-mua-pop-up-window-size 5
;;         bbdb-phone-style nil
;;         org-bbdb-anniversary-field 'birthday))

;; (use-package counsel-bbdb
;;   :ensure t
;;   :config
;;   :bind (:map mu4e-compose-mode-map
;;               ("TAB" . counsel-bbdb-complete-mail)))


;; (setq bbdb/mail-auto-create-p 'bbdb-prune-not-to-me)
;; (setq bbdb/news-auto-create-p 'bbdb-prune-not-to-me)
;; (defun bbdb-prune-not-to-me ()
;;   "defun called when bbdb is trying to automatically create a record.  Filters out
;; anything not actually adressed to me then passes control to 'bbdb-ignore-some-messages-hook'.
;; Also filters out anything that is precedense 'junk' or 'bulk'  This code is from
;; Ronan Waide < waider @ waider . ie >."
;;   (let ((case-fold-search t)
;;         (done nil)
;;         (b (current-buffer))
;;         (marker (bbdb-header-start))
;;         field regexp fieldval)
;;     (set-buffer (marker-buffer marker))
;;     (save-excursion
;;       ;; Hey ho. The buffer we're in is the mail file, narrowed to the
;;       ;; current message.
;;       (let (to cc precedence)
;;         (goto-char marker)
;;         (setq to (bbdb-extract-field-value "To"))
;;         (goto-char marker)
;;         (setq cc (bbdb-extract-field-value "Cc"))
;;         (goto-char marker)
;;         (setq precedence (bbdb-extract-field-value "Precedence"))
;;         ;; Here's where you put your email information.
;;         ;; Basically, you just add all the regexps you want for
;;         ;; both the 'to' field and the 'cc' field.
;;         (if (and (not (string-match "fandresp@" (or to "")))
;;                  (not (string-match "fandresp@" (or cc ""))))
;;             (progn
;;               (message "BBDB unfiling; message to: %s cc: %s"
;;                        (or to "noone") (or cc "noone"))
;;               ;; Return nil so that the record isn't added.
;;               nil)

;;           (if (string-match "junk" (or precedence ""))
;;               (progn
;;                 (message "precedence set to junk, bbdb ignoring.")
;;                 nil)

;;             ;; Otherwise add, subject to filtering
;;             (bbdb-ignore-some-messages-hook)))))))
