;;; iw-paredit.el --- Setup paredit                  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Iain Wood

;; Author: Iain Wood <iain@soulflyer.co.uk>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

(require 'use-package)

;;; Code:
(use-package paredit
  :ensure t
  :bind (:map paredit-mode-map
              ("C-<left>"   . paredit-backward)
	      ("C-<right>"  . paredit-forward)
	      ("C-<up>"     . paredit-backward-up)
	      ("C-<down>"   . paredit-forward-down)
	      ("C-c j"      . paredit-join-sexp)
	      ("C-c s"      . paredit-split-sexp)
	      ("C-c u"      . paredit-splice-sexp)
	      ("C-c f s"    . paredit-forward-slurp-sexp)
	      ("C-c b s"    . paredit-backward-slurp-sexp)
	      ("C-c f b"    . paredit-forward-barf-sexp)
	      ("C-c b b"    . paredit-backward-barf-sexp)
              ("C-c w ("    . paredit-wrap-round)
              ("C-c w {"    . paredit-wrap-curly)
              ("C-c w ["    . paredit-wrap-square)
              ("C-c w \""   . paredit-meta-doublequote)
              ("M-)"        . paredit-forward-slurp-sexp)
              ("M-\""       . paredit-meta-doublequote)
              ("M-("        . paredit-wrap-round)
              ;; Bad things happen if M-[ gets remapped . Lose the fn keys for a start.
              ;; ("M-["        . paredit-wrap-square)
              ("M-{"        . paredit-wrap-curly)))

;; Stop paredit from shooting you in the foot by pasting unbalanced parens.
;; from https://trey-jackson.blogspot.com/2009/09/emacs-tip-33-paredit.html
(defun paredit-check-region-for-yank ()
  "Run after 'yank' and 'yank-pop' to verify balanced parens."
  (when paredit-mode
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
  (paredit-check-region-for-yank))
(defadvice yank-pop (after yank-pop-check-parens activate)
  "."
  (paredit-check-region-for-yank))

(add-hook 'prog-mode-hook '(lambda () (paredit-mode 1)))
(provide 'iw-paredit)
;;; iw-paredit.el ends here
