;;; iw-modeline.el ---                               -*- lexical-binding: t; -*-
;; Copyright (C) 2023  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;; This allows a different colour to be used for the modeline text based on a
;; variable 'project-colour' set in dir-locals.el like this:
;;
;; ((nil . ((project-colour . "#d0d040"))))
;;
;; Works in files, Dired, and eshell.  In eshell the colour will change when cd-ing.
;;; Code:

(defvar project-colour  "#20d030")

(defun iw-change-modeline-colour (&rest _ignore)
  "Whatever."
  (set-face-attribute 'mode-line nil :foreground project-colour))

(add-hook 'window-selection-change-functions #'iw-change-modeline-colour)
(add-hook 'window-buffer-change-functions #'iw-change-modeline-colour)
(add-hook 'eshell-after-prompt-hook #'iw-change-modeline-colour)
(add-hook 'eshell-after-prompt-hook #'hack-dir-local-variables-non-file-buffer)
;;(remove-hook 'eshell-after-prompt-hook #'hack-dir-local-variables-non-file-buffer)
;; Using an anonymous fn here because hack-dir-local-variables-non-file-buffer takes no params,
;; but window-buffer-change-functions expects fns that take 1 param.
;;c(add-hook 'window-buffer-change-functions #'(lambda (_) (hack-dir-local-variables-non-file-buffer)))
;; (remove-hook 'window-buffer-change-functions #'(lambda (_) (hack-dir-local-variables-non-file-buffer)))
(add-hook 'dired-before-readin-hook #'iw-change-modeline-colour)

(provide 'iw-modeline)
;;; iw-modeline.el ends here
