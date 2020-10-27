(require 'use-package)
(use-package counsel
  :config (setq ivy-count-format "%d/%d:"
                ivy-use-virtual-buffers t
                ivy-use-selectable-prompt t)

  :bind (("M-x"     . counsel-M-x )
         ("C-s"     . swiper)
         ("C-x C-f" . counsel-find-file)
         ("C-h v"   . counsel-describe-variable)
         ("C-h f"   . counsel-describe-function)
         :map minibuffer-local-map
         ("C-r"     . counsel-minibuffer-history)))
