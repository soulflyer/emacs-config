;;; iw-dash.el ---                                   -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:

;;; Code:

;; (use-package helm-dash
;;   :ensure t)

(use-package counsel-dash
  :ensure t
  :config
  (setq counsel-dash-browser-func 'eww)
  (add-hook 'emacs-lisp-mode-hook (lambda () (setq-local counsel-dash-docsets '("Emacs_Lisp"))))
  (add-hook 'clojure-mode-hook (lambda () (setq-local counsel-dash-docsets '("Clojure"))))
  (add-hook 'shell-script-mode-hook (lambda () (setq-local counsel-dash-docsets '("Bash"))))
  :bind (("C-c C-d C-d" . counsel-dash-at-point )))

(provide 'iw-dash)
;;; iw-dash.el ends here
