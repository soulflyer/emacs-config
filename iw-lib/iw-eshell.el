;;; iw-eshell.el ---                                 -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;; eshell-prompt-extras can do git prompt, but doesn't use colours for status
;; eshell-git-prompt does colours.
;; Neither of these are easily customizable
;;; Code:

;; Taken from https://emacs.stackexchange.com/a/18569/2666

(setq eshell-destroy-buffer-when-process-dies t
      eshell-save-history-on-exit nil
      eshell-visual-subcommands '(("git" "log" "diff")))

(defun eshell-append-history ()
  "Call `eshell-write-history' with the `append' parameter set to `t'."
  (when eshell-history-ring
    (let ((newest-cmd-ring (make-ring 1)))
      (ring-insert newest-cmd-ring (car (ring-elements eshell-history-ring)))
      (let ((eshell-history-ring newest-cmd-ring))
        (eshell-write-history eshell-history-file-name t)))))

(add-hook 'eshell-pre-command-hook #'eshell-append-history)


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
