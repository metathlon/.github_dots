;;; ~/.doom.d/org.el -*- lexical-binding: t; -*-


(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)

(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(defadvice org-capture-destroy
    (after delete-capture-frame activate)
  "Advise capture-destroy to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))
