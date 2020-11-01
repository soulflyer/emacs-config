;;; iw-cleanup --- tidy up the display
;;; Commentary:
;;; Code:
(require 'use-package)

;;; get rid of clutter
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq inhibit-startup-message t
      shift-select-mode t
      require-final-newline t
      delete-by-moving-to-trash t
      make-backup-files nil ; stop creating those backup~ files
      auto-save-default nil ; stop creating those #autosave# files
      )

;;; remove bells
(setq ring-bell-function 'ignore)

(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'cider-repl-mode))

(setq-default truncate-lines t)

(defun live-delete-whitespace-except-one ()
  "Remove all whitespace except one."
  (interactive)
  (cycle-spacing -1))

;;remove all trailing whitespace and trailing blank lines before
;;saving the file
(defvar live-ignore-whitespace-modes '(markdown-mode))
(defun live-cleanup-whitespace ()
  "Cleanup spurious whitespace.  Salvaged from Sam Aarons emacs-live config."
  (if (not (member major-mode live-ignore-whitespace-modes))
      (let ((whitespace-style '(trailing empty)) )
        (whitespace-cleanup))))

(add-hook 'before-save-hook 'live-cleanup-whitespace)


(provide 'iw-cleanup)
;;; iw-cleanup.el ends here
