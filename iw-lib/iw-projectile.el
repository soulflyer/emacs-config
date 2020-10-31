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

(provide 'iw-projectile)
;;; iw-projectile.el ends here
