;;; iw-display-buffer.el ---                         -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@subversion>

;;; Commentary:

;;; Code:

;; By default always open in the same window
;; (setq display-buffer-base-action
;;       '(( display-buffer-same-window)))

;; Help and org-mode will try to reuse a window
;; FIXME org-agenda doesn't seem to obey this.
(setq display-buffer-base-action
      '((display-buffer-reuse-window
         display-buffer-reuse-mode-window
         display-buffer-same-window)
        . ((mode . (org-mode org-agenda-mode help-mode apropos-mode diary-mode calendar-mode)))))

(provide 'iw-display-buffer)
;;; iw-display-buffer.el ends here
