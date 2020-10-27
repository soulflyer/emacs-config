(require 'use-package)
(use-package projectile
  :config
  (setq projectile-completion-system 'ivy))
(use-package ripgrep
  :bind (([f6] . projectile-ripgrep)))
