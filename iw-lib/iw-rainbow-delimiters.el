;;; iw-rainbow-delimiters --- setup pretty parens
;;; Commentary:

;;; Code:
(require 'use-package)
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(provide 'iw-rainbow-delimiters)
;;; iw-rainbow-delimiters.el ends here
