;;; iw-paredit.el --- Setup paredit                  -*- lexical-binding: t; -*-

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
(use-package paredit
  :ensure t
  :bind (("C-<left>"	. paredit-backward)
	 ("C-<right>"	. paredit-forward)
	 ("C-<up>"	. paredit-backward-up)
	 ("C-<down>"	. paredit-forward-down)
	 ("C-c j"	. paredit-join-sexp)
	 ("C-c s"	. paredit-split-sexp)
	 ("C-c u"	. paredit-splice-sexp)
	 ("C-c f s"	. paredit-forward-slurp-sexp)
	 ("C-c b s"	. paredit-backward-slurp-sexp)
	 ("C-c f b"	. paredit-forward-barf-sexp)
	 ("C-c b b"	. paredit-backward-barf-sexp)
         ("M-)"         . paredit-forward-slurp-sexp)
         ("M-\""        . paredit-meta-doublequote)))

(provide 'iw-paredit)
;;; iw-paredit.el ends here
