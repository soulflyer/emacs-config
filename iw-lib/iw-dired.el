;;; iw-dired --- tweaks to dired
;;; Commentary:
;;; ls-lisp stops Dired complaining about the builtin ls not handling the Dired option.
;;; Note the use of :map within the Dired :bind.
;;; This ensures the bindings are added after dired-mode is entered.

;;; Code:
(defun dired-make-file (new-file-name)
  "Add file creation to DIRED NEW-FILE-NAME."
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
  ;;  :pin manual
  :config (setq find-file-visit-truename t
                dired-guess-shell-alist-user '((".pdf" "open")))
  :bind (:map dired-mode-map
	      ("f"   . 'dired-make-file)
	      ("/"   . 'dired-up-directory)
	      ("\\"  . 'dired-up-directory)
              ("C-s" . 'swiper)
              ("1"   . 'dired-do-shell-command)))

(use-package openwith
  :ensure t)

(use-package dired-efap
  :ensure t
  :bind (:map dired-mode-map
              ("r"   . 'dired-efap))
  :config
  (setq dired-efap-initial-filename-selection nil))

(use-package dired-ranger
  :ensure t
  :bind (:map dired-mode-map
              ("c" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("v" . dired-ranger-paste)))

(provide 'iw-dired)
;;; iw-dired.el ends here
