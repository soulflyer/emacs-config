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

(when (member "Monaco" (font-family-list))
  (set-frame-font "Monaco-12" t t))

(blink-cursor-mode 0)
(setq cursor-type 'bar)

(use-package font-utils
  :ensure t)

(use-package unicode-fonts
  :ensure t
  :config
  (unicode-fonts-setup)
  (setq
   unicode-fonts-block-font-mapping '(("Box Drawing"
                                       ("Menlo" "FreeMono" "DejaVu Sans" "Everson Mono" "Quivira" "Code2000" "Noto Sans Symbols" "Segoe UI Symbol" "Symbola"))
                                      ("Geometric Shapes Extended"
                                       ("Apple Color Emoji" "Symbola" "Quivira"))
                                      ("Miscellaneous Symbols and Arrows"
                                       ("JuliaMono" "DejaVu Sans Mono" "Apple Color Emoji" "Symbola" "Quivira" "Asana Math" "Code2000" "Segoe UI Symbol" "Noto Sans Symbols"))
                                      ("Miscellaneous Symbols and Pictographs"
                                       ("Apple Color Emoji" "Segoe UI Symbol" "Symbola" "Quivira")))
   unicode-fonts-overrides-mapping '(("Black Large Square" "White Large Square"
                                      ("Apple Color Emoji"))
                                     )))

(use-package pdf-tools
  :ensure t)

(provide 'iw-gui-emacs)
;;; iw-gui-emacs.el ends here
