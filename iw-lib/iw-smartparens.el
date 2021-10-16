;;; iw-smartparens.el --- setup smartparens          -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood;;; iw-smartparens --- setup smartparens <iain@soulflyer.co.uk>

;;; Commentary:
;; Code to allow wrap without having to define a region first comes from:
;; https://ebzzry.io/en/emacs-pairs/
;;
;; Code to stop pasting unbalanced parens comes from:
;; from https://trey-jackson.blogspot.com/2009/09/emacs-tip-33-paredit.html


(require 'use-package)

;;; Code:
(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode)
  (smartparens-global-strict-mode)
  (show-paren-mode)
  :config
  (require 'smartparens-config)
  ;;(add-hook 'prog-mode-hook #'smartparens-mode)

  :bind (:map smartparens-mode-map
              ("C-<left>"  . sp-backward-sexp)
	      ("C-<right>" . sp-forward-sexp)
	      ("C-<up>"    . sp-up-sexp)
	      ("C-<down>"  . sp-down-sexp)
	      ("C-c j"     . sp-join-sexp)
	      ("C-c s"     . sp-split-sexp)
	      ("C-c u"     . sp-splice-sexp)
	      ("C-c f s"   . sp-forward-slurp-sexp)
	      ("C-c b s"   . sp-backward-slurp-sexp)
	      ("C-c f b"   . sp-forward-barf-sexp)
	      ("C-c b b"   . sp-backward-barf-sexp)
              ("C-c b k"   . iw-backward-kill-sexp)
              ("M-)"       . sp-forward-slurp-sexp)
              ("M-\""      . sp-wrap-with-double-quote)
              ("M-("       . sp-wrap-with-round)
              ("M-{"       . sp-wrap-with-curly)))

(defmacro def-pairs (pairs)
  "Define functions for pairing.  PAIRS is an alist of (NAME . STRING)
conses, where NAME is the function name that will be created and
STRING is a single-character string that marks the opening character.

  (def-pairs ((paren . \"(\")
              (bracket . \"[\"))

defines the functions WRAP-WITH-PAREN and WRAP-WITH-BRACKET,
respectively."
  `(progn
     ,@(loop for (key . val) in pairs
             collect
             `(defun ,(read (concat
                             "sp-wrap-with-"
                             (prin1-to-string key)))
                  (&optional arg)
                (interactive "p")
                (sp-wrap-with-pair ,val)))))

(def-pairs ((round        . "(")
            (square       . "[")
            (curly        . "{")
            (single-quote . "'")
            (double-quote . "\"")))

(defun iw-backward-kill-sexp ()
  "Delete everything back to the start of the sexp"
  (interactive)
  (let ((current-prefix-arg '(4))) ;; emulate C-u
    (call-interactively 'sp-backward-kill-sexp)))

;; Stop pasting unbalanced parens.
(defun sp-check-region-for-yank ()
  "Run after 'yank' and 'yank-pop' to verify balanced parens."
  (when smartparens-mode
    (save-excursion
      (save-restriction
        (narrow-to-region (point) (mark))
        (condition-case nil
            (check-parens)
          (error
           (if (not (y-or-n-p "The text inserted has unbalanced parentheses, continue? "))
               (delete-region (point-min) (point-max)))))))))

(defadvice yank (after yank-check-parens activate)
  "."
  (sp-check-region-for-yank))

(defadvice yank-pop (after yank-pop-check-parens activate)
  "."
  (sp-check-region-for-yank))

(provide 'iw-smartparens)
;;; iw-smartparens.el ends here
