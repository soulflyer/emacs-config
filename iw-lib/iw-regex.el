;;; iw-regex.el ---                                  -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:
;;

;;; Code:

(use-package visual-regexp
  :ensure t
  :bind (("C-c r r" . vr/replace)
         ("C-c r q" . vr/query-replace)
         ("C-c r m" . vr/mc-mark)))

(provide 'iw-regex)
;;; iw-regex.el ends here
