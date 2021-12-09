;;; iw-deft.el ---                                   -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:

;; This does the same thing as nvALT and can share notes
;; iw-deft-complete is lifted from 2 fns in deft and is there so that
;; when searching in deft fails to find a note, hitting return will
;; create a new zetteldeft note.

;;; Code:

(use-package deft
  :ensure t
  :config
  (setq deft-use-filename-as-title t
        deft-use-filter-string-for-filename t
        deft-default-extension "org"
        deft-auto-save-interval 10.0)
  (advice-add 'deft :after #'deft-refresh))

(use-package zetteldeft
  :ensure t
  :after deft
  :config
  (zetteldeft-set-classic-keybindings)
  (setq zetteldeft-id-format "%y%m%d%H%M"
        zetteldeft-id-regex "[0-9]\\{10\\}"
        zetteldeft-title-suffix "\n# Tags #"
        zetteldeft-home-id "2109122138"))

(defun iw-deft-complete ()
  "Complete the current action.
If there is a button at the point, press it.  If a filter is
applied and there is at least one match, open the first matching
file.  If there is an active filter but there are no matches,
quick create a new file using the filter string as the title.
Otherwise, ask for a note name and create a new file."
  (interactive)
  (cond
   ;; Activate button
   ((button-at (point))
    (push-button))
   ;; Active filter string with match
   ((and deft-filter-regexp deft-current-files)
    (deft-open-file (car deft-current-files)))
   ;; Default
   (t
    (let (slug)
      (if (and deft-filter-regexp deft-use-filter-string-for-filename)
          ;; If the filter string is non-emtpy and titles are taken from
          ;; filenames is set, construct filename from filter string.
          (setq slug (deft-whole-filter-regexp))
        ;; If the filter string is empty, or titles are taken from file
        ;; contents, then use an automatically generated unique filename.
        (setq slug (read-string "New note title: ")))
      (zetteldeft-new-file slug)))))

(defun iw-nv-zd ()
  "This relies on the babashka script nv-zd which converts a deft note in a
text file into a zetteldeft note in an org file and returns the new file name"
  (interactive)
  (let ((command (format "nv-zd '%s'" (buffer-file-name))))
    (zetteldeft-find-file (shell-command-to-string command))
    (deft-refresh)))

(define-key deft-mode-map (kbd "RET") 'iw-deft-complete)

(provide 'iw-deft)
;;; iw-deft.el ends here
