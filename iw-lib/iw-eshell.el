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
      eshell-visual-subcommands '(("git" "log" "diff" "show"))
      eshell-history-size nil)

(defun eshell-append-history ()
  "Call `eshell-write-history' with the `append' parameter set to t."
  (when eshell-history-ring
    (let ((newest-cmd-ring (make-ring 1)))
      (ring-insert newest-cmd-ring (car (ring-elements eshell-history-ring)))
      (let ((eshell-history-ring newest-cmd-ring))
        (eshell-write-history eshell-history-file-name t)))))

(add-hook 'eshell-pre-command-hook #'eshell-append-history)
(with-eval-after-load 'esh-mode
  (define-key eshell-mode-map (kbd "C-r") 'counsel-esh-history))

(use-package eshell-git-prompt
  :ensure t)

(defface eshell-git-prompt-clean-face
  '((t :foreground "#44aa22"))
  "Face for git branch (clean) in eshell git prompt theme `iain`"
  :group 'eshell-faces)

(defface eshell-git-prompt-ahead-face
  '((t :foreground "#ee9f49"))
  "Face for git branch (ahead) in eshell git prompt theme `iain`"
  :group 'eshell-faces)

(defface eshell-git-prompt-dirty-face
  '((t :foreground "#ee0000"))
  "Face for git branch (dirty) in eshell git prompt theme `iain`"
  :group 'eshell-faces)

(defun git-face ()
  "Returns the face that matches the status of the directory. Throws an error if
called when not in a directory under git control"
  (if (eshell-git-prompt--collect-status)
      'eshell-git-prompt-dirty-face
    (if (= 0 (eshell-git-prompt--commits-ahead-of-remote))
        'eshell-git-prompt-clean-face
      'eshell-git-prompt-ahead-face)))

(defun eshell-git-prompt-iain ()
  "Builds a prompt string similar to that produced by '_git_ps1'"
  (when (eshell-git-prompt--git-root-dir)
    (setq eshell-git-prompt-branch-name
          (eshell-git-prompt--branch-name)
          eshell-git-prompt-remote-branch-name
          (eshell-git-prompt--remote-branch-name)))
  (let (branch prompt path-dir)
    (setq branch (if (eshell-git-prompt--git-root-dir) (with-face (concat "(" (eshell-git-prompt--branch-name) ") ") (git-face))))
    (setq prompt (with-face " λ:" 'eshell-git-prompt-clean-face))
    (setq path-dir (with-face (eshell-git-prompt--shorten-directory-name) 'eshell-git-prompt-clean-face))
    ;; The space is there because it will reset the colour. If it is part of prompt, then all typed text is in the prompt's face.
    (eshell-git-prompt---str-read-only
     (concat branch path-dir prompt " "))))

(defconst eshell-git-prompt-iain-regexp "^[^\n#λ]*[#λ]: ")

(setq eshell-git-prompt-themes
      '((iain eshell-git-prompt-iain eshell-git-prompt-iain-regexp)
        (robbyrussell eshell-git-prompt-robbyrussell eshell-git-prompt-robbyrussell-regexp)
        (git-radar eshell-git-prompt-git-radar eshell-git-prompt-git-radar-regexp)
        (powerline eshell-git-prompt-powerline eshell-git-prompt-powerline-regexp)
        (multiline eshell-git-prompt-multiline eshell-git-prompt-multiline-regexp)
        (multiline2 eshell-git-prompt-multiline2 eshell-git-prompt-multiline2-regexp)
        (simple eshell-git-prompt-simple eshell-git-prompt-simple-regexp)
        (default eshell-git-prompt-default-func eshell-git-prompt-default-regexp))
      eshell-prompt-function 'eshell-git-prompt-iain
      eshell-prompt-regexp "^[^\12#λ]*[#λ]: "
      eshell-modules-list
      '(eshell-alias eshell-banner eshell-basic eshell-cmpl eshell-dirs eshell-hist eshell-extpipe eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-script eshell-term eshell-unix))

(provide 'iw-eshell)
;;; iw-eshell.el ends here
