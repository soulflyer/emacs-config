;;; iw-ibuffer --- tidy up ibuffer display
;;; Commentary:

(require 'use-package)
;;; Code:

(use-package ibuffer-git
  :ensure t
  :config (setq ibuffer-formats '((mark modified read-only git-status-mini " "
					(size 7 -1 :left :elide)
					(name))
				  (mark filename))))

(provide 'iw-ibuffer)
;;; iw-ibuffer.el ends here
