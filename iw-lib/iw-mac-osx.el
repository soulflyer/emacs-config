;;; iw-mac-osx.el --- osx specific setup
;;; Commentary:
;;; Mostly taken from Sam Aarons emacs-live

(require 'use-package)
;;; Code:

(setq default-input-method "MacOSX")

(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))

(use-package osx-dictionary
  :ensure t)

(use-package launchctl
  :ensure t)

;; FIXME This is being run when emacs is started as a daemon and fills the kill-ring with junk
;; It may still be useful in terminal emacs

(defun live-paste-to-osx (text &optional push)
  "Paste TEXT to the clipboard.  PUSH."
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
;;
;; (when (not window-system)
;;   (setq interprogram-cut-function 'live-paste-to-osx))

(defun iw-open-bookshelf ()
  (interactive)
  (shell-command (concat "osascript -e 'mount volume \"smb://iain@subversion.local/bookshelf\"'"))
  (find-file "~/Documents/books/bookshelf/"))

(provide 'iw-mac-osx)
;;; iw-mac-osx.el ends here
