;;; iw-burly.el ---                                  -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(use-package burly
  :ensure t
  :init
  (burly-tabs-mode)
  (setq burly-bookmark-prefix ""))

(provide 'iw-burly)
;;; iw-burly.el ends here
