;;; iw-dashboard.el ---                              -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Iain Wood

;; Author: Iain Wood <iain@acceptance.local>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
        initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
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
