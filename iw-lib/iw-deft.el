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
  :config (zetteldeft-set-classic-keybindings)
  (setq zetteldeft-id-format "%y%m%d%H%M"
        zetteldeft-id-regex "[0-9]\\{10\\}"
        zetteldeft-title-suffix "\n# Tags #"))

(provide 'iw-deft)
;;; iw-deft.el ends here
