;;; iw-deft.el ---                                   -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Iain Wood

;; Author: Iain Wood <iain@soulflyer.co.uk>
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

;; This does the same thing as nvALT and can share notes

;;; Code:

(use-package deft
  :ensure t
  :config
  (setq deft-use-filename-as-title t
        deft-use-filter-string-for-filename t
        deft-default-extension "org"))

(use-package zetteldeft
  :ensure t
  :after deft
  :config
  (zetteldeft-set-classic-keybindings)
  (setq zetteldeft-id-format "%y%m%d%H%M"
        zetteldeft-id-regex "[0-9]\\{10\\}"
        zetteldeft-title-suffix "\n# Tags #")
  :bind
  (("C-c d e" . zetteldeft-extract-region-to-note)))

(defun iw-deft-complete ()
  "Complete the current action.
If there is a button at the point, press it.  If a filter is
applied and there is at least one match, open the first matching
file.  If there is an active filter but there are no matches,
quick create a new file using the filter string as the title.
Otherwise, quick create a new file."
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
        (setq slug (deft-unused-slug)))
      (zetteldeft-new-file slug)))))

(define-key deft-mode-map (kbd "RET") 'iw-deft-complete)

(provide 'iw-deft)
;;; iw-deft.el ends here
