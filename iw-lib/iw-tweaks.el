;;; iw-tweaks.el --- Improve the interface           -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:

;;; Code:

;; This allows us to use space to accept y/n questions.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Save minbuffer history
(setq-default savehist-autosave-interval 30)
(setq savehist-mode t)

(setq-default glogal-visual-line-mode t)
(add-hook 'dired-mode-hook          (lambda () (visual-line-mode -1)))
(add-hook 'ibuffer-mode-hook        (lambda () (visual-line-mode -1)))
(add-hook 'dashboard-mode-hook      (lambda () (visual-line-mode -1)))
(add-hook 'org-agenda-mode-hook     (lambda () (visual-line-mode -1)))
;; tabulated-list-mode underlies paradox-menu-mode.
(add-hook 'tabulated-list-mode-hook (lambda () (visual-line-mode -1)))
;; TODO why does Text mode ignore global-visual-line-mode?
(add-hook 'text-mode-hook           (lambda () (visual-line-mode  1)))

(use-package highlight-context-line
  :ensure t
  :config
  (highlight-context-line-mode 1))

;; Make sure environment variables are set for clojure repl
(use-package direnv
  :ensure t
  :config
  (direnv-mode))

;; This allows easy tweaking of colours. Select some text and do M-x make-color
;; to open the make-color buffer, select something and press n, then adjust the colour
;; Colours can be changed by RGB HSL CMY keys, upper case to increase, lower to decrease
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

;; Beacon mode is set up here to emulate a block cursor when it is moving, but revert to
;; a bar when it stops. This is set for GUI Emacs in iw-gui-emacs.el using:
;; (blink-cursor-mode 0)
;; (setq cursor-type 'bar)
;; Terminal emacs uses the settings in iTerm profiles.
;; FIXME This seems to be the root cause of emacs slowing down. Find out what causes this
;; and fix it or create a fn to turn it off.
(use-package beacon
  :ensure t
  :init
  (setq beacon-size 4
        beacon-blink-when-focused t
        beacon-blink-when-point-moves-horizontally 0
        beacon-blink-when-point-moves-vertically 0
        beacon-color "#a424a4"
        beacon-blink-delay 0.2
        beacon-blink-duration 0.3
        beacon-dont-blink-major-modes '(cider-repl-mode)
        beacon-dont-blink-commands nil
        beacon-blink-when-window-scrolls t)
  :config
  (beacon-mode 1))

(use-package origami
  :ensure t
  :bind (("C-c C-c f" . origami-mode)
         :map origami-mode-map
         ("C-c C-c t" . origami-toggle-node)
         ("C-c C-c o" . origami-open-node-recursively)
         ("C-c C-c a" . origami-toggle-all-nodes)
         ("C-c C-c 1" . origami-show-only-node)
         ("C-c C-c q" . origami-open-all-nodes)))

;; This is so org agenda can see changes made on another machine
(global-auto-revert-mode)

;; Turn on the line/col display in the status bar
(column-number-mode 1)

(provide 'iw-tweaks)
;;; iw-tweaks.el ends here
