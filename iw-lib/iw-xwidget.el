;;; iw-xwidget.el ---                                -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(use-package xwwp
  :ensure t)

(defun xwidget-webkit-copy ()
  (interactive)
  (xwidget-webkit-copy-selection-as-kill)
  (live-paste-to-osx (first kill-ring)))

(defun browse-open-in-external ()
  (interactive)
  (xwidget-webkit-current-url)
  (browse-url-default-macosx-browser (first kill-ring)))

(define-key xwidget-webkit-mode-map (kbd "c") 'xwidget-webkit-copy)
(define-key xwidget-webkit-mode-map (kbd "x") 'browse-open-in-external)
(define-key eww-mode-map (kbd "x")            'browse-open-in-external)

(provide 'iw-xwidget)
;;; iw-xwidget.el ends here
