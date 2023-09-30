;;; iw-modeline.el ---                               -*- lexical-binding: t; -*-
;; Copyright (C) 2023  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(defvar project-colour  "#20d030")

(defun iw-change-modeline-colour (&rest _ignore)
  "Whatever."
  (set-face-attribute 'mode-line nil :foreground project-colour))

(add-hook 'window-selection-change-functions #'iw-change-modeline-colour)
(add-hook 'window-buffer-change-functions #'iw-change-modeline-colour)
(add-hook 'eshell-after-prompt-hook #'iw-change-modeline-colour)
(add-hook 'eshell-after-prompt-hook #'hack-dir-local-variables-non-file-buffer)
(add-hook 'window-buffer-change-functions #'hack-dir-local-variables-non-file-buffer)
(add-hook 'dired-before-readin-hook #'iw-change-modeline-colour)

(provide 'iw-modeline)
;;; iw-modeline.el ends here
