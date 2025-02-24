;;; iw-tab.el ---                                   -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(require 'calendar)
(defvar tab-bar-calendar-tab-name "Calendar")
(defvar tab-bar-home-tab-name "Home")

(setq tab-bar-close-button-show nil
      tab-bar-show 1
      tab-bar-format '(tab-bar-format-tabs tab-bar-separator)
      tab-bar-auto-width nil)

(defun tab-bar-tab-names ()
  (mapcar #'(lambda (tab) (alist-get 'name tab))
	  (tab-bar-tabs)))

(defun tab-bar-tab-exists (name)
  (member name (tab-bar-tab-names)))

(defun tab-calendar ()
  "Open the calendar and diary in a new tab if \=tab-bar-mode\= is on.
 Otherwise just open the calendar."
  (interactive)
  (if (not tab-bar-mode)
      (calendar)
    (if (tab-bar-tab-exists tab-bar-calendar-tab-name)
        (tab-bar-select-tab-by-name tab-bar-calendar-tab-name)
      (tab-new)
      (tab-bar-rename-tab tab-bar-calendar-tab-name)
      (calendar)
      (diary-show-all-entries)
      (scroll-other-window-down))))

(defun tab-calendar-exit ()
  "Close the calendar tab if it exists, or the calendar window if not."
  (interactive)
  (if (not (and (tab-bar-mode) (tab-bar-tab-exists tab-bar-calendar-tab-name)))
      (calendar-exit)
    (tab-bar-select-tab-by-name tab-bar-calendar-tab-name)
    (tab-bar-close-tab)))

(defun tab-workspace-default-layout (directory)
  (dired directory)
  (split-window-right (truncate (* (frame-width) 0.6)))
  (other-window 1)
  (split-window-below -15)
  (other-window 1)
  (eshell t)
  (cd directory)
  (other-window 1))

(defun tab-workspace-home-layout ()
  (interactive)
  (deft)
  (split-window-right (truncate (* (frame-width) 0.6)))
  (other-window 1)
  (org-agenda-list)
  (split-window-below 15)
  (other-window 1)
  (dired "~/")
  (split-window-below -15)
  (other-window 1)
  (eshell t)
  (cd "~")
  (eshell/clear-scrollback)
  (eshell-send-input)
  (recenter-top-bottom 0)
  (other-window 1))

(defun tab-workspace-home ()
  (interactive)
  (if (tab-bar-tab-exists tab-bar-home-tab-name)
      (tab-bar-select-tab-by-name tab-bar-home-tab-name)
    (tab-new)
    (tab-bar-rename-tab tab-bar-home-tab-name)
    (tab-workspace-home-layout)))

(defun tab-workspace-new (&optional path-name tab-title)
  "Create a new workspace called TAB-TITLE on PATH-NAME or the current directory."
  (interactive)
  (let ((directory (expand-file-name (or path-name default-directory)))
        (name (or tab-title
                  (file-name-nondirectory
                   (directory-file-name
                    (or path-name default-directory))))))
    (message "Workspace directory is: %s, Tab name is %s" directory name)
    (if (tab-bar-tab-exists name)
        (tab-bar-select-tab-by-name name)
      (tab-new)
      (tab-bar-rename-tab name)
      (tab-workspace-default-layout directory))))

(defun read-new-tab-name (&optional directory)
  (read-directory-name "New tab: " directory))

(require 'f)
(defun read-new-tab-name-and-create (&optional path-name tab-title)
  "Create a new workspace called TAB-TITLE on PATH-NAME or the current directory."
  (interactive)
  (let ((directory (expand-file-name (read-new-tab-name (or path-name
                                                            default-directory)))))
    (let ((name (or tab-title
                    (car (last (f-split directory))))))
      (message "Workspace directory is: %s, Tab name is %s" directory name)
      (if (tab-bar-tab-exists name)
          (tab-bar-select-tab-by-name name)
        (tab-new)
        (tab-bar-rename-tab name)
        (tab-workspace-default-layout directory)))))

(defun tab-music ()
  (interactive)
  (if (tab-bar-tab-exists "Music")
      (tab-bar-select-tab-by-name "Music")
    (tab-new)
    (tab-bar-rename-tab "Music")
    (emms-browser)
    (split-window-right (truncate (* (frame-width) 0.6)))
    (other-window 1)
    (dired "/Volumes/Crucial/Movies")
    (split-window-below 25)
    (other-window 1)
    (dired "~/Music/Collection")
    (split-window-below -10)
    (other-window 1)
    (emms)))

(defun tab-workspace-only-home ()
  "Whatever."
  (interactive)
  (tab-workspace-home)
  (tab-close-other))

(defun tab-kill-and-close ()
  "Whatever."
  (interactive)
  (projectile-kill-buffers)
  (tab-close))

(provide 'iw-tab)
;;; iw-tab.el ends here
