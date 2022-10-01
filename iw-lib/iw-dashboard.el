;;; iw-dashboard.el ---                              -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Iain Wood

;; Author: Iain Wood <iain@acceptance.local>
;; Keywords:

;;; Commentary:

;;

;;; Code:
(require 'use-package)

(defun fortune-string-list (n)
  "Creates a list of n fortunes"
  (cl-loop for i
           below n
           collect (shell-command-to-string "fortune")))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((projects . 5)
                          (recents  . 12)
                          (bookmarks . 5)
                          (registers . 5))
        initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
        dashboard-projects-switch-function 'find-file
        dashboard-startup-banner (concat user-emacs-directory "banners/small-80.txt")
        dashboard-footer-messages (fortune-string-list 1)
        dashboard-force-refresh t))

;; In order to see a new fortune with every emacsclient we must refresh the list and set
;; dashboard-force-refresh to something other than nil
(add-hook 'after-make-frame-functions
          #'(lambda (_) (setq dashboard-footer-messages (fortune-string-list 1))))

(provide 'iw-dashboard)
;;; iw-dashboard.el ends here
