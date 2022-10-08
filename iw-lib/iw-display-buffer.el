;;; iw-display-buffer.el ---                         -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@subversion>

;;; Commentary:

;;; Code:

(use-package shackle
  :ensure t)

(setq split-window-preferred-function 'split-window-sensibly
      split-width-threshold 80
      pop-up-windows t)

(setq display-buffer-base-action
      '((display-buffer-reuse-window
         display-buffer-reuse-mode-window
         display-buffer-same-window)))

(setq display-buffer-alist
      '(("*undo-tree*"     display-buffer-in-direction
         (side . right)
         (window-width . 30))
        ("*calendar*"      (display-buffer-reuse-window
                            display-buffer-below-selected))
        ("diary"           display-buffer-use-some-window)
        ("Agenda Commands" display-buffer-below-selected)
        ("Org Select"      display-buffer-below-selected)
        ("CAPTURE-"        display-buffer-below-selected)))

(provide 'iw-display-buffer)
;;; iw-display-buffer.el ends here
