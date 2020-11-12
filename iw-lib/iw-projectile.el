;;; iw-projectile --- Setup projectile
;;; Commentary:

(require 'use-package)

;;; Code:
(use-package async
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy))

(use-package ripgrep
  :ensure t
  :bind (([f6] . projectile-ripgrep)))

(defun iw-projectile-ripgrep-re-frame-defn ()
  "Find a reframe event or subscription definition."
  (interactive)
  (projectile-ripgrep (concat " " (projectile-symbol-or-selection-at-point))))

(global-set-key [f5] 'iw-projectile-ripgrep-re-frame-defn)
(define-key ripgrep-search-mode-map [\t] 'compilation-next-error)

(provide 'iw-projectile)
;;; iw-projectile.el ends here
