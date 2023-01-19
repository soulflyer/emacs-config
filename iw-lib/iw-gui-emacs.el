;;; iw-gui-emacs.el ---                              -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;; Code:
(message "Running GUI Emacs config")

(add-to-list 'default-frame-alist '(undecorated . t))
(set-face-attribute 'default nil :height 140)
(when (member "MonacoB2" (font-family-list))
  (set-frame-font "MonacoB2" t t))
(when (member "Apple Color Emoji" (font-family-list))
  (set-fontset-font t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend)
  (add-to-list 'face-font-rescale-alist (cons (font-spec :family "Apple Color Emoji") 0.92) t))
(setq frame-resize-pixelwise t)

(blink-cursor-mode 0)
(setq-default
 cursor-type 'bar
 cursor-in-non-selected-windows '(hbar . 1))

(defun iw-set-font-size ()
  "Adjust the font size in all windows."
  (interactive)
  (let (font-size)
    (setq font-size (read-number "Text size: "))
    (set-frame-font (font-spec :size font-size) t `(,(selected-frame)))))

(use-package font-utils
  :ensure t)

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

(provide 'iw-gui-emacs)
;;; iw-gui-emacs.el ends here
