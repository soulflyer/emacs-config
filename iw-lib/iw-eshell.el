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

(use-package eshell-git-prompt
  :ensure t)

(defface eshell-git-prompt-clean-face
  '((t :foreground "green"))
  "Face for git branch (clean) in eshell git prompt theme `iain`"
  :group 'eshell-faces)

(defface eshell-git-prompt-ahead-face
  '((t :foreground "gold"))
  "Face for git branch (ahead) in eshell git prompt theme `iain`"
  :group 'eshell-faces)

(defface eshell-git-prompt-dirty-face
  '((t :foreground "red"))
  "Face for git branch (dirty) in eshell git prompt theme `iain`"
  :group 'eshell-faces)

(defun git-face ()
  (if (eshell-git-prompt--collect-status)
      (if (/= 0 (eshell-git-prompt--commits-ahead-of-remote))
          'eshell-git-prompt-dirty-face
        'eshell-git-prompt-ahead-face)
    'eshell-git-prompt-clean-face))

(defun eshell-git-prompt-iain ()
  (let (branch prompt path-dir)
    (setq branch (if (eshell-git-prompt--git-root-dir) (with-face (concat "(" (eshell-git-prompt--branch-name) ") ") (git-face))))
    (setq prompt (with-face " λ: " 'eshell-git-prompt-clean-face))
    (setq path-dir (with-face (eshell-git-prompt--shorten-directory-name) 'eshell-git-prompt-clean-face))
    (eshell-git-prompt---str-read-only
     (concat branch path-dir prompt))))

(defconst eshell-git-prompt-iain-regexp "^[^\n#λ]*[#λ]:")

;; (use-package eshell-prompt-extras
;;   :ensure t
;;   :init
;;   (with-eval-after-load "esh-opt"
;;     (autoload 'epe-theme-lambda "eshell-prompt-extras")
;;     (setq eshell-highlight-prompt nil
;;           eshell-prompt-function 'epe-theme-lambda)))

(use-package load-bash-alias
  :ensure t
  :config
  (setq load-bash-alias-bashrc-file "~/.bashrc"))

(provide 'iw-eshell)
;;; iw-eshell.el ends here
