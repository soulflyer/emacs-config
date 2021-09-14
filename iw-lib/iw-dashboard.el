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

(defun fortune-string-list ()
  "Creates a list containing one entry. No point having more as the list is refreshed whenever
the server or a client is started and only one entry is used between server restarts"
  (list (shell-command-to-string "/opt/homebrew/bin/fortune")))

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
        dashboard-footer-messages (fortune-string-list)))

(add-hook 'server-visit-hook #'(lambda () (setq dashboard-footer-messages (fortune-string-list))))

(provide 'iw-dashboard)
;;; iw-dashboard.el ends here
