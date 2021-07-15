;;; iw-display-buffer.el ---                         -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Iain Wood

;; Author: Iain Wood <iain@subversion>
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

;; By default always open in the same window
(setq display-buffer-base-action
      '(( display-buffer-same-window)))

;; Help and org-mode will try to reuse a window
;; Appropos steals the whole frame. Why? Related to popwin mode. May need to remove it for gui emacs.
(setq display-buffer-base-action
      '((display-buffer-reuse-window
         display-buffer-reuse-mode-window
         display-buffer-same-window)
        . ((mode . (org-mode help-mode apropos-mode diary-mode calendar-mode)))))

;; (setq display-buffer-base-action
;;       '((display-buffer-reuse-window
;;          display-buffer-reuse-mode-window
;;          display-buffer-same-window
;;          display-buffer-in-previous-window)))

(provide 'iw-display-buffer)
;;; iw-display-buffer.el ends here
