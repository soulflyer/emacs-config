;;; iw-auto-complete.el --- autocomplete setup       -*- lexical-binding: t; -*-

;; Copyright (C) 2020  test

;; Author: test <test@subversion.local>
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

(require 'use-package)
;;; Code:

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (global-auto-complete-mode t)
  :custom-face
  (popup-face ((t (:inherit default :background "#303030" :foreground "yellow"))))
  (popup-tip-face ((t (:background "#303030" :foreground "#20d020")))))

(provide 'iw-auto-complete)
;;; iw-auto-complete.el ends here
