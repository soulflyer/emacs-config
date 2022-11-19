;;; iw-emoji.el ---                                  -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;; Emojify mode interferes with Unicode font display
;;; Code:

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package emoji-cheat-sheet-plus
  :defer t
  :init
  (progn
    ;; enabled emoji in buffer
    (add-hook 'org-mode-hook 'emoji-cheat-sheet-plus-display-mode)
    ;; insert emoji with helm
    (global-set-key (kbd "C-c t e") 'emoji-cheat-sheet-plus-insert)))

(provide 'iw-emoji)
;;; iw-emoji.el ends here
