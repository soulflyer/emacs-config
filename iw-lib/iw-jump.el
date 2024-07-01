;;; iw-jumaap.el --- Setup jumping.                  -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:
;; ace-jump-mode uses deprecated package: CL.
;; TODO Consider switching to AVY instead.  Will need to modify
;; jump-char.el to call avy instead of ace-jump.
;; TODO consider combining jump and search with ace-search

;; frog-jump-buffer works in gui Emacs but not command line.  ace-jump-buffer works ok.
;; jump-tree doesn't work in command line version.  The cursor is invisible so there is
;; no way to see where its jumping to.  This is probably interaction with tmux.  The
;; cursor is never visible in an unfocussed frame.

;; back-button could be improved by adding smartrep.  Let's see how much it gets used first.
;; Have to unbind C-c SPC so it doesn't steal the set-mark command.

(require 'use-package)

;;; Code:

(use-package ace-jump-mode
  :ensure t
  :bind (("M-j" . ace-jump-word-mode)))

(use-package jump-char
  :ensure t)

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
