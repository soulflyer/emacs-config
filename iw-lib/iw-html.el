;;; iw-html.el ---                                   -*- lexical-binding: t; -*-
;; Copyright (C) 2024  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(use-package web-mode
  :ensure t
  :init
  (setq web-mode-enable-current-element-highlight t)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

(provide 'iw-html)
;;; iw-html.el ends here
