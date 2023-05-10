;;; iw-javascript.el --- Setup for javascript        -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:

(require 'use-package)

;;; Code:
(setq js-indent-level 2)

(use-package js-comint
  :ensure t)

;; (use-package js2-mode
;;   :ensure t
;;   :mode
;;   (("\\.js\\'" . js2-mode)))

(use-package nvm
  :ensure t)

(use-package ts-comint
  :ensure t)

(use-package web-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package company
  :ensure t)



(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :init (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  :hook ((web-mode . (lambda ()
                       (when (string-equal "tsx" (file-name-extension buffer-file-name))
                         (tide-setup))))
         (typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :bind (:map typescript-mode-map
              ("M-RET" . 'tide-documentation-at-point)))

(provide 'iw-javascript)
;;; iw-javascript.el ends here
