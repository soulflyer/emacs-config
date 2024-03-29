;;; iw-visible-mark.el --- Setup visible-mark to show the mark ring.  -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;; This is mostly for use with multiple-cursors mc/mark-pop
`
(require 'use-package)

;;; Code:

(defface visible-mark-face3 `((t (:background "#609000")))
  "Face for the mark."
  :group 'visible-mark)

(defface visible-mark-face4 `((t (:background "#507000")))
  "Face for the mark."
  :group 'visible-mark)

(defface visible-mark-face5 `((t (:background "#405000")))
  "Face for the mark."
  :group 'visible-mark)

(defface visible-mark-face6 `((t (:background "#305000")))
  "Face for the mark."
  :group 'visible-mark)

(defface visible-mark-face7 `((t (:background "#205020")))
  "Face for the mark."
  :group 'visible-mark)

(defface visible-mark-face8 `((t (:background "#104020")))
  "Face for the mark."
  :group 'visible-mark)

(use-package visible-mark
  :ensure t
  :init
  (setq visible-mark-faces '(visible-mark-face1
                             visible-mark-face2
                             visible-mark-face3
                             visible-mark-face4
                             visible-mark-face5
                             visible-mark-face6
                             visible-mark-face7
                             visible-mark-face8))
  (setq visible-mark-max 8)
  :bind (("C-c v" . visible-mark-mode)))

(defun iw-set-mark-no-activate ()
  "Set the mark without activating the region."
  (interactive)
  (push-mark))

(global-set-key (kbd "C-x m") 'iw-set-mark-no-activate)

(provide 'iw-visible-mark)
;;; iw-visible-mark.el ends here
