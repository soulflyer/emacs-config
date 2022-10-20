;;; iw-reify.el ---                                  -*- lexical-binding: t; -*-

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

;;

;;; Code:

(defun egg-site-repl ()
  (interactive)
  (setenv "PORT" "2999")
  (setenv "DATABASE_URL" (getenv "SITE_DATABASE_URL"))
  (setq cider-inject-dependencies-at-jack-in nil)
  (setq cider-lein-parameters "with-profiles +bengal site-repl :headless :host localhost")
  (cider-jack-in-clj ()))

(defun egg-sponsor-repl ()
  (interactive)
  (setenv "PORT" "3000") ; set to default in case you've already run site-repl
  (setenv "DATABASE_URL" (getenv "SPONSOR_DATABASE_URL"))
  (setq cider-inject-dependencies-at-jack-in nil)
  (setq cider-lein-parameters "with-profiles +bengal sponsor-repl :headless :host localhost")
  (cider-jack-in-clj ()))


(provide 'iw-reify)
;;; iw-reify.el ends here
