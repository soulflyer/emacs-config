;;; iw-gui-emacs.el ---                              -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;; Code:
(message "Running GUI Emacs config")

;;(require 'iw-edwina)
;;(require 'iw-exwm)
;;(require 'iw-workgroups2)

;;(switch-to-buffer "*Messages*")

;; set font for symbols
;; (set-fontset-font
;;  t
;;  'symbol
;;  (cond
;;   ((member "Symbola" (font-family-list)) "Symbola")
;;   ((member "Apple Symbols" (font-family-list)) "Apple Symbols")
;;   ))

;; (set-fontset-font t 'symbol "Apple Color Emoji")
(when (member "Monaco" (font-family-list))
  (set-frame-font "Monaco-12" t t))

(blink-cursor-mode 0)
(setq cursor-type 'bar)

(use-package font-utils
  :ensure t)

;; (add-to-list 'face-font-rescale-alist
;;              (cons (font-spec :family "Apple Color Emoji") 0.91) t)
;; (set-fontset-font t '(#x1F7E0 . #x1F7EB) "Apple Color Emoji")
;; (set-fontset-font t '(#x2B05 . #x2B1C) "Apple Color Emoji")

(use-package unicode-fonts
  :ensure t
  :config
  (unicode-fonts-setup)
  (setq unicode-fonts-block-font-mapping
        '(("Box Drawing"
           ("Menlo" "FreeMono" "DejaVu Sans" "Everson Mono" "Quivira" "Code2000" "Noto Sans Symbols" "Segoe UI Symbol" "Symbola"))
          ("Geometric Shapes Extended"
           ("Apple Color Emoji" "Symbola" "Quivira"))
          ("Miscellaneous Symbols and Arrows"
           ("JuliaMono" "DejaVu Sans Mono" "Apple Color Emoji" "Symbola" "Quivira" "Asana Math" "Code2000" "Segoe UI Symbol" "Noto Sans Symbols"))
          ("Miscellaneous Symbols and Pictographs"
           ("Apple Color Emoji" "Segoe UI Symbol" "Symbola" "Quivira"))
          )))


(provide 'iw-gui-emacs)
;;; iw-gui-emacs.el ends here
