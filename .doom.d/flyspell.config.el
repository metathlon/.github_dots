;;; ~/.doom.d/nueva_config/flyspell.config.el -*- lexical-binding: t; -*-

;; * Flyspell
;; Gestor ortográfico para múltiples modos de emacs

(add-hook 'org-mode-hook (lambda() (flyspell-mode)))
(add-hook 'mu4e-compose-mode-hook (lambda() (flyspell-mode)))
;; (add-hook 'org-mode-hook 'turn-on-flyspell)
;; (add-hook 'org-mode-hook 'turn-on-auto-fill)
;; (add-hook 'mu4e-compose-mode-hook 'turn-on-flyspell)
;; (add-hook 'mu4e-compose-mode-hook 'turn-on-auto-fill)
