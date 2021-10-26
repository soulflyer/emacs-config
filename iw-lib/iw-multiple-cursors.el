;;; iw-multiple-cursors.el --- Setup multiple cursors   -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:

(require 'use-package)

;;; Code:

(use-package multiple-cursors
  :ensure t
  :bind (("C-c m n" . mc/mark-next-like-this)
         ("C-c m p" . mc/mark-previous-like-this)
         ("C-c m o" . mc/mark-pop)
         ("C-c m m" . mc/mark-more-like-this-extended)
         ("C-c m d" . mc/mark-all-dwim)
         ("C-c m a" . mc/mark-all-like-this)
         ("C-c m r" . vr/mc-mark)))

(provide 'iw-multiple-cursors)
;;; iw-multiple-cursors.el ends here
