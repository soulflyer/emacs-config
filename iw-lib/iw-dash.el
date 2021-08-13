;;; iw-dash.el ---                                   -*- lexical-binding: t; -*-

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

(use-package helm-dash
  :ensure t)

(use-package counsel-dash
  :ensure t
  :config
  (setq counsel-dash-browser-func 'eww)
  (add-hook 'emacs-lisp-mode-hook (lambda () (setq-local counsel-dash-docsets '("Emacs_Lisp"))))
  (add-hook 'clojure-mode-hook (lambda () (setq-local counsel-dash-docsets '("Clojure"))))
  (add-hook 'shell-script-mode-hook (lambda () (setq-local counsel-dash-docsets '("Bash"))))
  :bind (("C-c d" . counsel-dash-at-point )))

(provide 'iw-dash)
;;; iw-dash.el ends here
