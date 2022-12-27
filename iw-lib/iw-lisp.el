;;; iw-lisp.el --- Setup for lisp                    -*- lexical-binding: t; -*-

;;; Commentary:
;; Credit to Sam Aaron for describe thing at point.

;;; Code:
(defun live-lisp-describe-thing-at-point ()
  "Show the documentation of the Elisp function and variable near point.
This checks in turn:
-- for a function name where point is
-- for a variable name where point is
-- for a surrounding function call"
  (interactive)
  (let (sym)
    ;; sigh, function-at-point is too clever.  we want only the first half.
    (cond ((setq sym (ignore-errors
                       (with-syntax-table emacs-lisp-mode-syntax-table
                         (save-excursion
                           (or (not (zerop (skip-syntax-backward "_w")))
                               (eq (char-syntax (char-after (point))) ?w)
                               (eq (char-syntax (char-after (point))) ?_)
                               (forward-sexp -1))
                           (skip-chars-forward "`'")
                           (let ((obj (read (current-buffer))))
                             (and (symbolp obj) (fboundp obj) obj))))))
           (describe-function sym))
          ((setq sym (variable-at-point)) (describe-variable sym)))))

;; Helpful does the job. Should probably check if it is installed and use
;; 'live-lisp-describe-thing-at-point' as a backup
;; (define-key lisp-mode-shared-map  (kbd "M-RET")  'live-lisp-describe-thing-at-point)
(define-key lisp-mode-shared-map  (kbd "M-RET")   'helpful-at-point)
;; Also handy for jumping to docs directly from an Info node
;; (define-key Info-mode-map      (kbd "M-RET")   'live-lisp-describe-thing-at-point)
(define-key Info-mode-map         (kbd "M-RET")   'helpful-at-point)
;; and for jumping to help from help
(define-key helpful-mode-map      (kbd "M-RET")   'helpful-at-point)

;;; Not necessary when using global aggressive indent
;;; (define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

(provide 'iw-lisp)
;;; iw-lisp.el ends here
