;;; iw-counsel --- add counsel
;;; Commentary:
;;; Include smex or counsel-M-x doesn't keep history.
;;; Code:
(require 'use-package)
(use-package smex)
(use-package counsel
  :ensure t
  :config (setq ivy-count-format "%d/%d:"
                ivy-use-virtual-buffers t
                ivy-use-selectable-prompt t)

  :bind (("M-x"     . counsel-M-x )
         ("C-s"     . swiper)
         ("C-x C-f" . counsel-find-file)
         ("C-h v"   . counsel-describe-variable)
         ("C-h f"   . counsel-describe-function)
	 ("C-x C-d" . counsel-dired)
	 ("C-x d"   . counsel-dired)
	 :map minibuffer-local-map
	 ("C-r"     . counsel-minibuffer-history)))

(provide 'iw-counsel)
;;; iw-counsel.el ends here
