;;; iw-gui-emacs.el ---                              -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;; Code:
(message "Running GUI Emacs config")

;; These are not applied to gui emacsclient frames although the second t implies
;; that they should be.  For now just leave them in emacs-custom.el too. The same
;; problem is there for the cursor type too. (blink seems to work though)
(set-face-attribute 'default nil :height 140)

;; I like Monaco, but it has no bold. Hasklig is ok, but this is better:
;; https://github.com/vjpr/monaco-bold
;; (when (member "Monaco" (font-family-list))
;;   (set-frame-font "Monaco" t t))
;; (when (member "Hasklig" (font-family-list))
;;   (set-frame-font "Hasklig" t t))
(when (member "MonacoB2" (font-family-list))
  (set-frame-font "MonacoB2" t t))

(blink-cursor-mode 0)
(setq
 cursor-type 'bar
 cursor-in-non-selected-windows '(hbar . 1))

(defun iw-set-font-size ()
  "Adjust the font size in all windows."
  (interactive)
  (let (font-size)
    (setq font-size (read-number "Text size: "))
    (set-frame-font (font-spec :size font-size) t `(,(selected-frame)))))

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
