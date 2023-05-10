;;; iw-flycheck --- set up syntax checking
;;; Commentary:
;;; Code:
(require 'use-package)
(use-package flycheck
  :ensure t
  :config
  (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq-default flycheck-emacs-lisp-load-path 'inherit)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-clojure
  :ensure t)

(provide 'iw-flycheck)
;;; iw-flycheck ends here
