;;; iw-smartparens --- setup smartparens
;;; Commentary:
(require 'use-package)
;;; Code:
(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode))

(provide 'iw-smartparens)
;;; iw-smartparens.el ends here
