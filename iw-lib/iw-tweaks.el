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

(setq-default ispell-program-name "aspell")

(setq-default glogal-visual-line-mode t)
(add-hook 'dired-mode-hook          (lambda () (visual-line-mode -1)))
(add-hook 'ibuffer-mode-hook        (lambda () (visual-line-mode -1)))
(add-hook 'dashboard-mode-hook      (lambda () (visual-line-mode -1)))
(add-hook 'org-agenda-mode-hook     (lambda () (visual-line-mode -1)))
(add-hook 'tabulated-list-mode-hook (lambda () (visual-line-mode -1)))
;; tabulated-list-mode underlies paradox-menu-mode.
;; TODO why does Text mode ignore global-visual-line-mode?
(add-hook 'text-mode-hook           (lambda () (visual-line-mode  1)))

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

(use-package beacon
  :ensure t
  :init
  (setq beacon-size 2
        beacon-blink-when-focused t
        beacon-blink-when-point-moves-horizontally 1
        beacon-blink-when-point-moves-vertically -1
        beacon-color "gray"
        beacon-blink-delay 0.3
        beacon-blink-duration 0.1
        beacon-dont-blink-major-modes '(cider-repl-mode)
        beacon-dont-blink-commands nil
        beacon-blink-when-window-scrolls t)
  :config
  (beacon-mode 1))

(use-package origami
  :ensure t
  ;; :bind (:map origami-mode-map
  ;;             ("C-c C-o t" . origami-toggle-node)
  ;;             ("C-c C-o o" . origami-open-node-recursively)
  ;;             ("C-c C-o a" . origami-toggle-all-nodes)
  ;;             ("C-c C-o s" . origami-show-only-node))
  )

;; This is so org agenda can see changes made on another machine
(global-auto-revert-mode)

;; Turn on the line/col display in the status bar
(column-number-mode 1)

(provide 'iw-tweaks)
;;; iw-tweaks.el ends here
