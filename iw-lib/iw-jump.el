;;; iw-jump.el --- Setup jumping.                    -*- lexical-binding: t; -*-

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
;; ace-jump-mode uses deprecated package: CL.
;; Consider switching to AVY instead.  Will need to modify
;; jump-char.el to call avy instead of ace-jump.

;; frog-jump-buffer works in gui Emacs but not command line.  ace-jump-buffer works ok.
;; jump-tree doesn't work in command line version.  The cursor is invisible so there is
;; no way to see where its jumping to.  This is probably interaction with tmux.  The
;; cursor is never visible in an unfocussed frame.

;; back-button could be improved by adding smartrep.  Let's see how much it gets used first.
;; Have to unbind C-c SPC so it doesn't steal the set-mark command.

(require 'use-package)

;;; Code:

(use-package ace-jump-mode
  :ensure t)

(use-package jump-char
  :ensure t
  :bind (("M-j" . jump-char-forward)))

(use-package back-button
  :ensure t
  :config
  (back-button-mode 1)
  :bind (:map back-button-mode-map
              ("C-x SPC" . nil)))

;; (use-package frog-jump-buffer
;;   :ensure t)

(use-package ace-jump-buffer
  :ensure t)

;; (use-package jump-tree
;;   :ensure t)

(provide 'iw-jump)
;;; iw-jump.el ends here
