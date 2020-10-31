;;; iw-flycheck --- set up syntax checking
;;; Commentary:
;;; Ispell setup is included here too.
;;; Code:
(require 'use-package)
(use-package flycheck
  :ensure t
  :config
  (setq-default flycheck-emacs-lisp-load-path 'inherit)
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq ispell-program-name "aspell")
  :custom-face (flycheck-info ((t (:underline "pink")))))

(use-package flycheck-clojure
  :ensure t)

(provide 'iw-flycheck)
;;; iw-flycheck ends here
