;;; ~/.doom.d/nueva_config/org.config.el -*- lexical-binding: t; -*-

;; (use-package org
;;   :ensure org-plus-contrib
;;   ;; The rest of your org-mode configuration
;; )

;; (after! org
  (require 'find-lisp)
  (require 'org-capture)
  (require 'org-agenda)
  ;; (def-package! org-contacts)

  ;; (load! "org.personal.config.el")
  (setq org-directory caronte/org-directory)
  (setq org-archive-location
       (concat org-directory "/ARCHIVADOS/%s_ARCHIVADO::datatree/")
    )

  ;; --- TODO SECUENCIA ---
  (setq org-todo-keywords
      '(
      (sequence "TODO(t)" "STARTED(s)" "|" "DONE(d)" "CANCELED(c)")
      )
  )

  (setq org-todo-keyword-faces
      '(
      ("TODO" . (:foreground "yellow" :weight bold))
      ("STARTED" . (:foreground: "green" :weight bold))
      ("CANCELED" . (:foreground "yellow" :background "red" :weight bold))
      ("DONE" . (:foreground "grey" :weight bold))
      )
  )

  ;; --- SECUENCIA PRIORIDAD ---
    ;; (setq org-highest-priority ?A)
    ;; (setq org-default-priority ?B)
    ;; (setq org-lowest-priority ?C)


  ;; --- EXPORTS ---
  ;; Esta seccion intenta limpiar la basura que deja latex cuando exportas un .org
  (setq org-latex-logfiles-extensions '("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl"))
  (setq org-latex-remove-logfiles t)

;; )


;; --- ORG CAPTURE ---
(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Pide a capture-finalize que cierre el frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(defadvice org-capture-destroy
    (after delete-capture-frame activate)
  "Pide a capture-destroy que cierre el frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))
