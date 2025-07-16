;;; iw-gui-emacs.el ---                              -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;; Code:
(message "Running GUI Emacs config")

;; Removes the window decoration bar including the red/yellow/green dots and the drag area
;; replace with this: (set-frame-parameter nil 'undecorated nil)
(add-to-list 'default-frame-alist '(undecorated . t))
(set-face-attribute 'default nil :height 140)
(when (member "MonacoB2" (font-family-list))
  (set-frame-font "MonacoB2" t t))
(when (member "Apple Color Emoji" (font-family-list))
  (set-fontset-font t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend)
  (add-to-list 'face-font-rescale-alist (cons (font-spec :family "Apple Color Emoji") 0.92) t))
(setq frame-resize-pixelwise t)

;; Set some fonts so the hello page displays correctly
(set-fontset-font t 'adlam           (font-spec :family "Noto Sans Adlam"))
(set-fontset-font t 'balinese        (font-spec :family "Noto Serif Balinese"))
(set-fontset-font t 'batak           (font-spec :family "Noto Sans Batak"))
(set-fontset-font t 'brahmi          (font-spec :family "Noto Sans Brahmi"))
(set-fontset-font t 'gothic          (font-spec :family "Noto Sans Gothic"))
(set-fontset-font t 'hanifi-rohingya (font-spec :family "Noto Sans Hanifi Rohingya"))
(set-fontset-font t 'kaithi          (font-spec :family "Noto Sans Kaithi"))
(set-fontset-font t 'kharoshthi      (font-spec :family "Noto Sans kharoshthi"))
(set-fontset-font t 'lepcha          (font-spec :family "Noto Sans Lepcha"))
(set-fontset-font t 'makasar         (font-spec :family "Noto Serif Makasar"))
(set-fontset-font t 'meetei-mayek    (font-spec :family "Noto Sans Meetei Mayek"))
(set-fontset-font t 'mende-kikakui   (font-spec :family "Noto Sans Mende Kikakui"))
(set-fontset-font t 'modi            (font-spec :family "Noto Sans Modi"))
(set-fontset-font t 'sharada         (font-spec :family "Noto Sans Sharada"))
(set-fontset-font t 'siddham         (font-spec :family "Noto Sans Siddham"))
(set-fontset-font t 'sundanese       (font-spec :family "Noto Sans Sundanese"))
(set-fontset-font t 'syloti-nagri    (font-spec :family "Noto Sans Syloti Nagri"))
(set-fontset-font t 'tai-tham        (font-spec :family "Noto Sans Tai Tham"))
(set-fontset-font t 'tirhuta         (font-spec :family "Noto Sans Tirhuta"))
(set-fontset-font t 'wancho          (font-spec :family "Noto Sans Wancho"))

(set-fontset-font t 'musical-symbol  (font-spec :family "Noto Music"))

(blink-cursor-mode 0)
(setq-default
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

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (define-key pdf-view-mode-map (kbd "x") 'iw-open-external))

(use-package org-pdftools
  :ensure t
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :ensure t)

(use-package nov
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

;; Bindings to command don't all work on daemon startup. This one gets ignored.
(global-set-key (kbd "s-x") 'counsel-M-x)

;; Similarly, this gets ignored. I think it needs to be a cons because add-to-list would not add
;; these as they are already in the alist, just being ignored.
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))

(provide 'iw-gui-emacs)
;;; iw-gui-emacs.el ends here
