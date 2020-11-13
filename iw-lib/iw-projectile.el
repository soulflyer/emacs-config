;;; iw-projectile.el --- Setup projectile.           -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Iain Wood

;; Author: Iain Wood;;; iw-projectile --- Setup projectile <iain@soulflyer.co.uk>
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

;; iw-projectile-ripgrep-re-frame-defn is a quick and dirty method of locating re-frame definitions.
;; It assumes that the name of an event or subcription in its definiton will be preceded by a space,
;; and any call to it will not as they are wrapped in square brackets.  If the code is formatted
;; strictly this will (always/usually?) be true.

;; This is also handy for jumping to an Emacs Lisp file from its require call.

;;; Code:

(require 'use-package)

;;; Code:
(use-package async
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy))

(use-package ripgrep
  :ensure t
  :bind (([f6] . projectile-ripgrep)))

(defun iw-projectile-ripgrep-re-frame-defn ()
  "Find a reframe event or subscription definition."
  (interactive)
  (projectile-ripgrep (concat " " (projectile-symbol-or-selection-at-point))))

(global-set-key [f5] 'iw-projectile-ripgrep-re-frame-defn)
(add-hook 'ripgrep-search-mode-hook '(lambda () (define-key ripgrep-search-mode-map (kbd "TAB") 'compilation-next-error)))

(provide 'iw-projectile)
;;; iw-projectile.el ends here
