;;; iw-tab.el ---                                   -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(defun tab-bar-tab-names ()
  (mapcar #'(lambda (tab) (alist-get 'name tab))
	  (tab-bar-tabs)))

(defun tab-bar-tab-exists (name)
  (member name (tab-bar-tab-names)))

(defun tab-calendar ()
  "Open the calendar and diary in a new tab if 'tab-bar-mode' is on.  Otherwise just open the calendar."
  (interactive)
  (if (not tab-bar-mode)
      (calendar)
    (if (tab-bar-tab-exists "Calendar")
        (tab-bar-select-tab-by-name "Calendar")
      (tab-new)
      (tab-bar-rename-tab "Calendar")
      (calendar)
      (diary-show-all-entries)
      (scroll-other-window-down))))

(defun tab-workspace-default-layout (directory)
  (dired directory)
  (split-window-right)
  (other-window 1)
  (split-window-below -15)
  (other-window 1)
  (eshell t)
  (cd directory))

(defun tab-workspace-home-layout ()
  (interactive)
  (deft)
  (split-window-right)
  (other-window 1)
  (org-agenda-list)
  (split-window-below 15)
  (other-window 1)
  (dired "~/Code")
  (split-window-below -12)
  (other-window 1)
  (eshell t)
  (cd "~"))

(defvar tab-bar-home-tab-name "home")

(defun tab-workspace-home ()
  (interactive)
  (if (tab-bar-tab-exists tab-bar-home-tab-name)
      (tab-bar-select-tab-by-name tab-bar-home-tab-name)
    (tab-new)
    (tab-bar-rename-tab tab-bar-home-tab-name)
    (tab-workspace-home-layout)))

(defun tab-workspace-new (&optional path-name tab-title)
  "Create a new workspace on DIRECTORY or the current directory."
  (interactive)
  (let ((directory (expand-file-name (or path-name default-directory)))
        (name (or tab-title (file-name-nondirectory (directory-file-name  (or path-name default-directory))))))
    (message "Directory is: %s name is %s" directory name)
    (if (tab-bar-tab-exists name)
        (tab-bar-select-tab-by-name name)
      (tab-new)
      (tab-bar-rename-tab name)
      (tab-workspace-default-layout directory))))

(provide 'iw-tab)
;;; iw-tab.el ends here
