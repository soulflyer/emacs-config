;;; iw-jump.el --- Setup jumping.                    -*- lexical-binding: t; -*-
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
  ;; This binding works, unlike the one in iw-global-bindings...
  :bind (("M-j" . ace-jump-word-mode)))

(use-package jump-char
  :ensure t)

(use-package back-button
  :ensure t
  :config
  (back-button-mode 1)
  :bind (:map back-button-mode-map
              ("C-x SPC" . nil)))
;;TODO find out why back-button bindings sometimes work and sometimes don't, IDIOT, its C-x not C-c
;; Use C-x left and C-x right to jump back and forward between recent locations in the file.

;; (use-package frog-jump-buffer
;;   :ensure t)

(use-package ace-jump-buffer
  :ensure t)

(use-package bln-mode
  :ensure t
  :bind (("s-<left>"   . bln-backward-half)
         ("s-<right>"  . bln-forward-half)
         ("s-<up>"     . bln-backward-half-v)
         ("s-<down>"   . bln-forward-half-v)
         ("M-s-<up>"   . bln-backward-half-b)
         ("M-s-<down>" . bln-forward-half-b)))

;; (use-package jump-tree
;;   :ensure t)

(provide 'iw-jump)
;;; iw-jump.el ends here
