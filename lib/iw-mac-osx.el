(require 'use-package)

(defun live-copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun live-paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

 (when (not window-system)
   (setq interprogram-cut-function 'live-paste-to-osx)
   (setq interprogram-paste-function 'live-copy-from-osx))

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))
