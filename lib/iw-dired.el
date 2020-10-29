;;; iw-dired --- tweaks to dired
;;; Commentary:
;;; ls-lisp stops dired complaining about the builtin ls not handling the dired option.
;;; Note the use of :map within the dired :bind.
;;; This ensures the bindings are added after dired-mode is entered.

;;; Code:
(defun dired-make-file (new-file-name)
  "Add file creation to dired NEW-FILE-NAME."
  (interactive "sFile name: ")
  (shell-command (concat "touch " new-file-name))
  (message "created %s" new-file-name)
  (message "major mode %s" major-mode)
  (if (string= major-mode "dired-mode")
      (revert-buffer))
  (dired-jump nil (expand-file-name new-file-name)))

(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil
      ls-lisp-verbosity '(uid))

(use-package dired
  :pin manual
  :bind (:map dired-mode-map
	      ("f"   . 'dired-make-file)
	      ("/"   . 'dired-up-directory)
	      ("\\"  . 'dired-up-directory)))

(provide 'iw-dired)
;;; iw-dired.el ends here
