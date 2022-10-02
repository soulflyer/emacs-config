;;; iw-eshell.el ---                                 -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;; eshell-prompt-extras can do git prompt, but doesn't use colours for status
;; eshell-git-prompt does colours.
;; Neither of these are easily customizable
;;; Code:

(use-package eshell-prompt-extras
  :ensure t
  :init
  (with-eval-after-load "esh-opt"
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda)))

(use-package load-bash-alias
  :ensure t
  :config
  (setq load-bash-alias-bashrc-file "~/.bashrc"))

(provide 'iw-eshell)
;;; iw-eshell.el ends here
