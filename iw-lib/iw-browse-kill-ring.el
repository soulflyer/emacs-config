;;; iw-browse-kill-ring.el --- use kill-ring-browse  -*- lexical-binding: t; -*-

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

;;

;;; Code:

(use-package browse-kill-ring
  :ensure t
  :bind (("M-y" . browse-kill-ring)))

;; This will save the system clipboard to the kill ring before a kill
;; which would overwrite it due to live-paste-to-osx.
;; Careful. it may fill the kill ring with junk.
;;(setq-default save-interprogram-paste-before-kill t)

(provide 'iw-browse-kill-ring)
;;; iw-browse-kill-ring.el ends here
