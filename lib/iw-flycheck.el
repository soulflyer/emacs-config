;;; iw-flycheck --- set up syntax checking
;;; Commentary:
;;; Code:
(require 'use-package)
(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-clojure)

(provide 'iw-flycheck)
;;; iw-flycheck ends here
