;;; iw-smartparens --- setup smartparens
;;; Commentary:
(require 'use-package)
;;; Code:
(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (smartparens-global-strict-mode)
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
  :bind (("C-<left>"	. sp-backward-sexp)
	 ("C-<right>"	. sp-forward-sexp)
	 ("C-<up>"	. sp-up-sexp)
	 ("C-<down>"	. sp-down-sexp)
	 ("C-c j"	. sp-join-sexp)
	 ("C-c s"	. sp-split-sexp)
	 ("C-c u"	. sp-splice-sexp)
	 ("C-c f s"	. sp-forward-slurp-sexp)
	 ("C-c b s"	. sp-backward-slurp-sexp)
	 ("C-c f b"	. sp-forward-barf-sexp)
	 ("C-c b b"	. sp-backward-barf-sexp)
	 ))

(provide 'iw-smartparens)
;;; iw-smartparens.el ends here
