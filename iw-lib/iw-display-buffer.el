;;; iw-display-buffer.el ---                         -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@subversion>

;;; Commentary:

;;; Code:

(use-package shackle
  :ensure t)

;; Without this undo-tree appears below the window
(setq split-window-preferred-function 'split-window-sensibly
      split-width-threshold nil)

(setq display-buffer-base-action
      '((display-buffer-same-window)))

(setq display-buffer-alist
      '(("*undo-tree*"     display-buffer-in-direction
         (direction . right)
         (window-width . 25))
        ("*calendar*"      (display-buffer-reuse-window
                            display-buffer-same-window))
        ("diary"           (display-buffer-reuse-window
                            display-buffer-in-direction)
         (direction . up))
        ("20[0-9][0-9]"    display-buffer-same-window
         (inhibit-same-window . nil))
        
        ("Agenda Commands"             display-buffer-below-selected)
        ("Org Select"                  display-buffer-below-selected)
        ("Org Src"                     display-buffer-below-selected)
        ("Org Links"                   display-buffer-no-window (allow-no-window . t))
        ("CAPTURE-"                    display-buffer-below-selected)
        ("*cider-error*"               display-buffer-below-selected)
        ("*cider-doc*"                 display-buffer-same-window (inhibit-same-window . nil))
        ("*cider-inspect*"             display-buffer-same-window (inhibit-same-window . nil))
        ("*cider-test-report*"         display-buffer-same-window (inhibit-same-window . nil))
        ("*J Console*"                 display-buffer-same-window (inhibit-same-window . nil))
        ("*Projectile Commander Help*" display-buffer-same-window (inhibit-same-window . nil))))

;; display-buffer-full-frame
(provide 'iw-display-buffer)
;;; iw-display-buffer.el ends here
