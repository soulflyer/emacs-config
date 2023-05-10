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
  :init (setq ibuffer-saved-filter-groups '(("modified"
                                             ("modified" (visiting-file) (modified))
                                             ("dired" (mode . dired-mode))
                                             ("code" (derived-mode . prog-mode))
                                             ("special" (name . "^\\*"))
                                             ("org-mode" (mode . org-mode))))
              ibuffer-saved-filters
              '(("modified"
                 (visiting-file)
                 (modified))
                ("org-mode"
                 (mode . org-mode))
                ("programming"
                 (or
                  (derived-mode . prog-mode)
                  (mode . ess-mode)
                  (mode . compilation-mode)))
                ("text document"
                 (and
                  (derived-mode . text-mode)
                  (not
                   (starred-name))))))
  :config (setq ibuffer-formats '((mark modified read-only " "
				        (size 7 -1 :left :elide)
				        (name))
			          (mark filename))
                )
  :bind (("C-x b"   . ibuffer)
	 ("C-x C-b" . ibuffer)
         :map ibuffer-mode-map ("\\" . ibuffer-switch-to-saved-filter-groups)))

(provide 'iw-ibuffer)
;;; iw-ibuffer.el ends here
