;;; iw-gui-emacs.el ---                              -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;; Code:
(message "Running GUI Emacs config")
(require 'iw-font)

;; Removes the window decoration bar including the red/yellow/green dots and the drag area
;; replace with this: (set-frame-parameter nil 'undecorated nil)
(add-to-list 'default-frame-alist '(undecorated . t))

(setq frame-resize-pixelwise t)

(blink-cursor-mode 0)
(setq-default
 cursor-type 'bar
 cursor-in-non-selected-windows '(hbar . 1))

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (define-key pdf-view-mode-map (kbd "x") 'iw-open-external))

(use-package org-pdftools
  :ensure t
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :ensure t)

(use-package nov
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

;; Bindings to command don't all work on daemon startup. This one gets ignored.
(global-set-key (kbd "s-x") 'execute-extended-command)

;; Similarly, this gets ignored. I think it needs to be a cons because add-to-list would not add
;; these as they are already in the alist, just being ignored.
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))

(provide 'iw-gui-emacs)
;;; iw-gui-emacs.el ends here
