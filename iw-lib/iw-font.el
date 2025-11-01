;;; iw-font.el --- Manipulate fonts for gui emacs    -*- lexical-binding: t; -*-
;; Copyright (C) 2025  iain
;; Author: iain <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

;; This sets the font size, height is given in 1/10 pts
(set-face-attribute 'default nil :height 140)
(when (member "MonacoB2" (font-family-list))
  (set-frame-font "MonacoB2" t t))
(when (member "Noto Color Emoji" (font-family-list))
  (set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji") nil 'prepend)
  (add-to-list 'face-font-rescale-alist (cons (font-spec :family "Noto Color Emoji") 0.95) t))


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

(defun iw-set-font-size ()
  "Adjust the font size in all windows."
  (interactive)
  (let (font-size)
    (setq font-size (read-number "Text size: "))
    (set-frame-font (font-spec :size font-size) t `(,(selected-frame)))))

;; for font-utils-exists-p etc. Currently not used
;; (use-package font-utils
;;   :ensure t)

(provide 'iw-font)
;;; iw-font.el ends here
