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

(setq display-buffer-base-action '((display-buffer-same-window))
      switch-to-buffer-obey-display-actions t)
;; Check out https://www.masteringemacs.org/article/demystifying-emacs-window-manager
;; emms uses switch-to-buffer not display-buffer so switch-to-buffer-obey-display-actions
;; needs to be set to t

(setq display-buffer-alist
      '(("*undo-tree*"     display-buffer-in-direction
         (direction . right)
         (window-width . 25))
        ("*calendar*"      (display-buffer-reuse-window
                            display-buffer-same-window))
        ("diary"           (display-buffer-reuse-window
                            display-buffer-in-direction)
         (direction . up))
        ("Org Agenda"      (display-buffer-reuse-window)
         (dedicated . t))
        ;; FIXME The following 3 items should be in one regex
        ;; but this doesn't work.
        ("\.org"
         (display-buffer-reuse-mode-window)
         (mode . (deft-mode org-mode lyrics-show-mode emms-browser-mode)))
        ("\.pdf"
         (display-buffer-reuse-mode-window)
         (mode . (deft-mode org-mode lyrics-show-mode emms-browser-mode)))
        ("EMMS-TAGS"
         (display-buffer-reuse-mode-window)
         (mode . (deft-mode org-mode lyrics-show-mode emms-browser-mode)))
        ("emms-browser-search" display-buffer-reuse-mode-window
         (mode . (emms-playlist-mode emms-mark-mode)))
        ("20[0-9][0-9]"    display-buffer-same-window
         (inhibit-same-window . nil))
        ("Agenda Commands"             display-buffer-below-selected)
        ("Org Select"                  display-buffer-below-selected)
        ("Org Src"                     display-buffer-below-selected)
        ("Org Attach"                  display-buffer-below-selected)
        ("Org Links"                   display-buffer-no-window (allow-no-window . t))
        ("CAPTURE-"                    display-buffer-below-selected)
        ("*cider-error*"               display-buffer-below-selected)
        ("*cider-doc*"                 display-buffer-same-window (inhibit-same-window . nil))
        ("*cider-ns-browser*"          display-buffer-same-window (inhibit-same-window . nil))
        ("*cider-inspect*"             display-buffer-same-window (inhibit-same-window . nil))
        ("*cider-test-report*"         display-buffer-same-window (inhibit-same-window . nil))
        ("*J Console*"                 display-buffer-same-window (inhibit-same-window . nil))
        ("*Projectile Commander Help*" display-buffer-same-window (inhibit-same-window . nil))
        ("*Info*"                      display-buffer-same-window (inhibit-same-window . nil))
        ("\*Man "                      display-buffer-same-window (inhibit-same-window . nil))))

;; display-buffer-full-frame
(provide 'iw-display-buffer)
;;; iw-display-buffer.el ends here
