;;; iw-gui-emacs.el ---                              -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:

;;

;;; Code:

(message "Running GUI Emacs config")

;;(require 'iw-edwina)
;;(require 'iw-exwm)
;;(require 'iw-workgroups2)

;;(switch-to-buffer "*Messages*")

;; set font for symbols
(set-fontset-font
 t
 'symbol
 (cond
  ((member "Symbola" (font-family-list)) "Symbola")
  ((member "Apple Symbols" (font-family-list)) "Apple Symbols")))

(when (member "Monaco" (font-family-list))
  (set-frame-font "Monaco-12" t t))

(set-fontset-font t '(#x1F7E0 . #x1F7EB) "Apple Color Emoji")
(set-fontset-font t '(#x2B1B . #x2B1C) "Apple Color Emoji")

(provide 'iw-gui-emacs)
;;; iw-gui-emacs.el ends here
