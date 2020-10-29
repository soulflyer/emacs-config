;;; iw-projectile --- Setup projectile
;;; Commentary:

;;; Code:
(require 'use-package)
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy))
(use-package ripgrep
  :ensure t
  :bind (([f6] . projectile-ripgrep)))

(provide 'iw-projectile)
;;; iw-projectile.el ends here
