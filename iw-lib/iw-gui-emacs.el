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

;; (when (member "Segoe UI Emoji" (font-family-list))
;;   (set-fontset-font
;;    t 'symbol (font-spec :family "Segoe UI Emoji") nil 'prepend))

(when (member "Apple Color Emoji" (font-family-list))
  (set-fontset-font
   t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend))

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

;; from https://emacs.stackexchange.com/a/62220/2666
(defun init-my-font ()
  (when (member "MonacoB2" (font-family-list))
    (set-frame-font "MonacoB2" t t))
  (set-fontset-font t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend)
  (add-to-list 'face-font-rescale-alist (cons (font-spec :family "Apple Color Emoji") 0.91) t))

(add-hook
 'server-after-make-frame-hook
 (let (done)
   (lambda ()
     (unless done
       ;; still set done to true even if we hit a bug (otherwise we
       ;; can never open a frame to see the problem)
       (setq done t)
       (init-my-font)))))

;; (use-package unicode-fonts
;;   :ensure t
;;   :config
;;   (unicode-fonts-setup)
;;   (setq
;;    unicode-fonts-block-font-mapping '(("Box Drawing"
;;                                        ("Menlo" "FreeMono" "DejaVu Sans" "Everson Mono" "Quivira" "Code2000" "Noto Sans Symbols" "Segoe UI Symbol" "Symbola"))
;;                                       ("Geometric Shapes Extended"
;;                                        ("Noto Sans Emoji" "Apple Color Emoji" "Symbola" "Quivira"))
;;                                       ("Miscellaneous Symbols and Arrows"
;;                                        ("JuliaMono" "DejaVu Sans Mono" "Apple Color Emoji" "Symbola" "Quivira" "Asana Math" "Code2000" "Segoe UI Symbol" "Noto Sans Symbols"))
;;                                       ("Miscellaneous Symbols and Pictographs"
;;                                        ("Apple Color Emoji" "Segoe UI Symbol" "Symbola" "Quivira")))
;;    unicode-fonts-overrides-mapping '(("Black Large Square" "White Large Square"
;;                                       ("Noto Sans Emoji"))
;;                                      ))
;;   )

(use-package pdf-tools
  :ensure t)

(provide 'iw-gui-emacs)
;;; iw-gui-emacs.el ends here
