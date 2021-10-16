;;; iw-projectile.el --- Setup projectile.           -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:

;; iw-projectile-ripgrep-re-frame-defn is a quick and dirty method of locating re-frame definitions.
;; It assumes that the name of an event or subcription in its definiton will be preceded by a space,
;; and any call to it will not as they are wrapped in square brackets.  If the code is formatted
;; strictly this will (always/usually?) be true.

;; This is also handy for jumping to an Emacs Lisp file from its require call.

;;; Code:

(require 'use-package)

;;; Code:
(use-package async
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy))

(use-package ripgrep
  :ensure t)

(use-package counsel-projectile
  :ensure t)

(defun iw-projectile-ripgrep-re-frame-defn ()
  "Find a reframe event or subscription definition."
  (interactive)
  (projectile-ripgrep (concat " " (projectile-symbol-or-selection-at-point))))

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "M-p")   'projectile-command-map)

(global-set-key [f4] 'projectile-find-file)
(global-set-key [f5] 'iw-projectile-ripgrep-re-frame-defn)
(global-set-key [f6] 'counsel-projectile-rg)
(global-set-key [f7] 'projectile-ripgrep)

(add-hook 'ripgrep-search-mode-hook #'(lambda () (define-key ripgrep-search-mode-map (kbd "TAB") 'compilation-next-error)))

(provide 'iw-projectile)
;;; iw-projectile.el ends here
