;;; iw-package.el ---                                -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;

;;; Code:
(require 'package)

(package-initialize)
(when (not (package-installed-p 'use-package))
  (package-install 'use-package))
(require 'use-package)
(require 'use-package-ensure)

(use-package paradox
  :ensure t
  :init (paradox-enable)
  :config
  (setq paradox-column-width-package 24))

(use-package delight
  :ensure t)

(provide 'iw-package)
;;; iw-package.el ends here
