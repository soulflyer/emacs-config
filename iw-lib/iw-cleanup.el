;;; iw-cleanup --- tidy up the display
;;; Commentary:
;;; Code:
(require 'use-package)

;;; get rid of clutter
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode)   (tool-bar-mode   -1))
(if (fboundp 'menu-bar-mode)   (menu-bar-mode   -1))

(setq inhibit-startup-message t
      shift-select-mode t
      require-final-newline t
      ;; following line might be useful on linux. Not on Mac
      ;; delete-by-moving-to-trash t
      )

(setq-default bookmark-fringe-mark nil
              bookmark-sort-flag nil)

(defvar emacs-backup-dir "~/.emacs-backups")
(setq backup-directory-alist         `((".*" . ,emacs-backup-dir))
      auto-save-file-name-transforms `((".*" ,(concat emacs-backup-dir "/autosaves/\\1") t)))

(setq backup-by-copying t   ; don't clobber symlinks
      version-control t     ; use versioned backups
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2)


;;; remove bells
(setq ring-bell-function 'ignore)

(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'cider-repl-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'org-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'clojure-mode))

;; This will expand a line of code that was written all on one line.
;; TODO move some of these somewhere better. Maybe iw-text.el
(use-package prog-fill
  :ensure t)

(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)
(add-hook 'Custom-mode-hook #'(lambda () (setq truncate-lines nil)))

(defun live-delete-whitespace-except-one ()
  "Remove all whitespace except one."
  (interactive)
  (cycle-spacing -1))

(defun iw-eol-and-delete-whitespace-except-one ()
  "Go to end of line and delete all whitespace except one."
  (interactive)
  (end-of-line)
  (just-one-space -1))

;;remove all trailing whitespace and trailing blank lines before
;;saving the file
(defvar live-ignore-whitespace-modes '(markdown-mode))
(defun live-cleanup-whitespace ()
  "Cleanup spurious whitespace.  Salvaged from Sam Aarons emacs-live config."
  (if (not (member major-mode live-ignore-whitespace-modes))
      (let ((whitespace-style '(trailing empty)))
        (whitespace-cleanup))))

;;(add-hook 'before-save-hook 'live-cleanup-whitespace)

;; from https://stackoverflow.com/a/7250027/1671119
;; For coding it would be beter to switch beginning-of-line-text and
;; beginning-of-visual-line but that would lose the ability to go to the point
;; where visual-line-mode has wrapped a long text line before going to the
;; actual start of the line.
(defun smart-line-beginning ()
  "Move to the beginning of the visual line.
If already there, then move it to the beginning of the real text."
  (interactive)
  (let ((pt (point)))
    (beginning-of-visual-line)
    (when (eq pt (point))
      (beginning-of-line-text))))

(defun smart-line-end ()
  "Move to end of visual line, if already there then move to end of real line."
  (interactive)
  (let ((pt (point)))
    (end-of-visual-line)
    (when (eq pt (point))
      (end-of-line))))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(provide 'iw-cleanup)
;;; iw-cleanup.el ends here
