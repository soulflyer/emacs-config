;;; iw-mac-osx.el --- osx specific setup
;;; Commentary:
;;; Code:
(require 'use-package)

(defun live-copy-from-osx ()
  "Copy from the osx clipboard."
  (shell-command-to-string "pbpaste"))

(defun live-paste-to-osx (text &optional push)
  "Copy TEXT to the osx clipboard.  Dunno what the optional PUSH is."
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

 (when (not window-system)
   (setq interprogram-cut-function 'live-paste-to-osx)
   (setq interprogram-paste-function 'live-copy-from-osx))

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(provide 'iw-mac-osx)
;;; iw-mac-osx.el ends here
