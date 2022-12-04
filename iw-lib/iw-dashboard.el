;;; iw-dashboard.el ---                              -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Iain Wood

;; Author: Iain Wood <iain@acceptance.local>
;; Keywords:

;;; Commentary:

;;

;;; Code:
(require 'use-package)

(defun fortune-string-list (n)
  "Create a list of N fortunes."
  (cl-loop for i
           below n
           collect (shell-command-to-string "fortune")))

;; This definition is lifted from 'dashboard-widgets.el' with the call to
;; 'dashboard-center-line' removed.
(defun dashboard-insert-footer-not-centred ()
  "Insert footer of dashboard."
  (when-let ((footer (and dashboard-set-footer (dashboard-random-footer))))
    (insert "\n")
    (insert dashboard-footer-icon)
    (insert " ")
    (insert (propertize footer 'face 'dashboard-footer))
    (insert "\n")))

(use-package dashboard
  :ensure t
  :config
  (advice-add 'dashboard-insert-footer :override #'dashboard-insert-footer-not-centred)      
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((bookmarks . 5)
                          (projects . 5)
                          (recents  . 12)
                          (registers . 5))
        initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
        dashboard-projects-switch-function 'find-file
        dashboard-startup-banner (concat user-emacs-directory "banners/small-80.txt")
        dashboard-footer-messages (fortune-string-list 1)
        dashboard-force-refresh t
        dashboard-footer-icon ""))

;; In order to see a new fortune with every emacsclient we must refresh the list and set
;; dashboard-force-refresh to something other than nil
(add-hook 'after-make-frame-functions
          #'(lambda (_) (setq dashboard-footer-messages (fortune-string-list 1))))

(provide 'iw-dashboard)
;;; iw-dashboard.el ends here
