;;; iw-ibuffer.el --- Tidy up ibuffer display        -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:
;; ibuffer-git is using cl which is deprecated.  Maybe there is an alternative?

;;; Code:

(require 'use-package)
;;; Code:

(use-package ibuffer-git
  :ensure t
  :config (setq ibuffer-formats '((mark modified read-only git-status-mini " "
				        (size 7 -1 :left :elide)
				        (name))
			          (mark filename))
                ibuffer-saved-filter-groups '(("default" ("modified" (modified) (visiting-file))))
                ibuffer-saved-filters '(("modified" (modified) (visiting-file))))
  :bind (("C-x b"   . ibuffer)
	 ("C-x C-b" . ibuffer)))

(provide 'iw-ibuffer)
;;; iw-ibuffer.el ends here
