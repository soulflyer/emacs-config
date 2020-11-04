;;; iw-mac-osx.el --- osx specific setup
;;; Commentary:
;;; Mostly taken from Sam Aarons emacs-live

(require 'use-package)
;;; Code:

(setq default-input-method "MacOSX")

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(defun live-paste-to-osx (text &optional push)
  "Paste TEXT to the clipboard.  PUSH."
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(when (not window-system)
  (setq interprogram-cut-function 'live-paste-to-osx))

(provide 'iw-mac-osx)
;;; iw-mac-osx.el ends here
