;;; iw-multiple-cursors.el --- Setup multiple cursors   -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Iain Wood

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

(require 'use-package)

;;; Code:

(use-package multiple-cursors
  :ensure t
  :bind (("C-c m n" . mc/mark-next-like-this)
         ("C-c m p" . mc/mark-previous-like-this)
         ("C-c m o" . mc/mark-pop)
         ("C-c m m" . mc/mark-more-like-this-extended)
         ("C-c m d" . mc/mark-all-dwim)
         ("C-c m a" . mc/mark-all-like-this)))

(use-package ace-mc
  :ensure t
  :bind (("C-c m j" . ace-mc-add-multiple-cursors)))

(provide 'iw-multiple-cursors)
;;; iw-multiple-cursors.el ends here
