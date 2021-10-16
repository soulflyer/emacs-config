;;; iw-eaf.el ---                                    -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@acceptance.local>

;;; Commentary:

;;; Code:
(require 'use-package)

(use-package quelpa
  :ensure t)

(use-package quelpa-use-package
  :ensure t)

;; TODO call this using quelpa-use-package
(quelpa '(eaf :fetcher github
              :repo  "manateelazycat/emacs-application-framework"
              :files ("*")))

(provide 'iw-eaf)
;;; iw-eaf.el ends here
