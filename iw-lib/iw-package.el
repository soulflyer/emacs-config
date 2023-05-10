;;; iw-package.el ---                                -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;

;;; Code:

(use-package paradox
  :ensure t
  :init (paradox-enable)
  :config
  (setq paradox-column-width-package 24
        paradox-github-token t))

(use-package delight
  :ensure t)

(provide 'iw-package)
;;; iw-package.el ends here
