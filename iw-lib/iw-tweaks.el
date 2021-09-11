;;; iw-tweaks.el --- Improve the interface           -*- lexical-binding: t; -*-

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

;;; Code:

;; This allows us to use space to accept y/n questions.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Save minbuffer history
(setq-default savehist-autosave-interval 30)
(setq savehist-mode t)

(setq-default ispell-program-name "aspell")

(setq-default glogal-visual-line-mode t)
(add-hook 'dired-mode-hook      (lambda () (visual-line-mode -1)))
(add-hook 'ibuffer-mode-hook    (lambda () (visual-line-mode -1)))
(add-hook 'dashboard-mode-hook  (lambda () (visual-line-mode -1)))
(add-hook 'org-agenda-mode-hook (lambda () (visual-line-mode -1)))

;; Make sure environment variables are set for clojure repl
(use-package direnv
  :ensure t
  :config
  (direnv-mode))

;; This allows easy tweaking of colours. Select some text and do M-x make-color
;; to open the make-color buffer, select something and press n, then adjust the colour
;; Colours can be changed by RGB HSL CMY keys, uper case to increase, lower to decrease
;; press k to add the current colour to the kill ring.
;; https://github.com/alezost/make-color.el
(use-package make-color
  :ensure t)

;; This will convert ascii codes into their key equivalents.
(use-package visual-ascii-mode
  :ensure t)

(use-package register-list
  :ensure t)

(use-package iregister
  :ensure t)

(use-package goto-last-change
  :ensure t
  :bind (("M-g c" . goto-last-change)))

;; This is only vaguely useful in terminal emacs. It will scroll the screen so the correct
;; position is visible but the cursor is not highlighted.
(use-package goto-char-preview
  :ensure t)

(use-package beacon
  :ensure t
  :init
  (setq beacon-size 60
        beacon-color "yellow"
        beacon-blink-delay 0.3
        beacon-blink-duration 0.1
        beacon-dont-blink-major-modes '(cider-repl-mode)
        beacon-blink-when-window-scrolls t
        beacon-mode 1) )

(use-package origami
  :ensure t
  :bind (:map origami-mode-map
              ("C-c C-o t" . origami-toggle-node)
              ("C-c C-o o" . origami-open-node-recursively)
              ("C-c C-o a" . origami-toggle-all-nodes)
              ("C-c C-o s" . origami-show-only-node)))

(when (member "Monaco" (font-family-list))
  (set-frame-font "Monaco-12" t t))

;; This is so org agenda can see changes made on another machine
(global-auto-revert-mode)

(provide 'iw-tweaks)
;;; iw-tweaks.el ends here
