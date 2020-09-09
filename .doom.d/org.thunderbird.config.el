;;; ~/.doom.d/nueva_config/org.thunderbird.config.el -*- lexical-binding: t; -*-

;; ** Thunderbird
;; Para enlazar Thunderbird y ORG-MODE hace falta un hack.

;; Se instala thunderlink, pero no está actualizado para la última versión de
;; thunderbird, así que tenemos que añadir lo siguiente a
;; ~/.thunderbird/xxxxxxxx/prefs.js

;; user_pref("extensions.thunderlink.custom-tl-string-1-title", "Org mode message-ID");
;; user_pref("extensions.thunderlink.custom-tl-string-1", "[[message://<messageid>][<subject>]]");
;; user_pref("extensions.thunderlink.custom-tl-string-1-selection-delimiter", " / ");
;; user_pref("extensions.thunderlink.custom-tl-string-1-clipboard-checkbox", true);
;; user_pref("extensions.thunderlink.custom-tl-string-1-tagcheckbox", false);
;; user_pref("extensions.thunderlink.custom-tl-string-1-tag", 1);
;; user_pref("extensions.thunderlink.custom-tl-string-1-appendtofile-checkbox", false);
;; user_pref("extensions.thunderlink.custom-tl-string-1-appendtofile-path", "");

;; NOTESE que donde pone "<subject>" en realidad es un link que es transformado por
;; orgmode directamente... su forma "expandida sería" [ [ message://<messageid> ] [ <subject>
;;  ] ] asi lo puedes ver bien, es eso pero sin los espacios.


;; #+BEGIN_SRC emacs-lisp
;; with org-mac-link message:// links are handed over to the macOS system,
;; which has built-in handling. On Windows and Linux, we can use thunderlink!
(when (not (string-equal system-type "darwin"))
  ;; modify this for your system
  (setq thunderbird-program "thunderbird")

  (defun org-message-thunderlink-open (slash-message-id)
    "Handler for org-link-set-parameters that converts a standard message:// link into
   a thunderlink and then invokes thunderbird."
    ;; remove any / at the start of slash-message-id to create real message-id
    (let ((message-id
           (replace-regexp-in-string (rx bos (* "/"))
                                     ""
                                     slash-message-id)))
      (start-process
       (concat "thunderlink: " message-id)
       nil
       thunderbird-program
       "-thunderlink"
       (concat "thunderlink://messageid=" message-id)
       )))
  ;; on message://aoeu link, this will call handler with //aoeu
  (org-link-set-parameters "message" :follow #'org-message-thunderlink-open))

;; #+END_SRC
