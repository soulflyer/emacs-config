;;; iw-ibuffer.el --- Tidy up ibuffer display        -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Iain Wood

;; Author: Iain Wood;;; iw-ibuffer --- tidy up ibuffer display <iain@soulflyer.co.uk>
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
;; ibuffer-git is using cl which is deprecated.  Maybe there is an alternative?

;;; Code:

(require 'use-package)
;;; Code:

(use-package ibuffer-git
  :ensure t
  :config (setq ibuffer-formats '((mark modified read-only git-status-mini " "
				        (size 7 -1 :left :elide)
				        (name))
			          (mark filename)))
  :bind (("C-x b"   . ibuffer)
	 ("C-x C-b" . ibuffer)))

(provide 'iw-ibuffer)
;;; iw-ibuffer.el ends here
