;;; iw-generic-mode.el ---                           -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(require 'generic-x)

(define-generic-mode 'skhdrc-mode
  '("#" ":")
  '("+" "ctrl" "shift" "alt" "cmd")
  '(("left"  . 'font-lock-builtin-face)
    ("right" . 'font-lock-builtin-face)
    ("down"  . 'font-lock-builtin-face)
    ("up"    . 'font-lock-builtin-face)
    (" [[:ascii:]]" . font-lock-builtin-face))
  '(".skhdrc\\'")
  nil
  "A mode for .skhdrc")

(provide 'iw-generic-mode)
;;; iw-generic-mode.el ends here
