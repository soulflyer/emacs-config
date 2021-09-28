;;; iw-text.el --- setup text tools                  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  test

;; Author: test <test@subversion.local>
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

;;; Code:

(use-package banner-comment
  :ensure t
  :bind
  (("C-c t b" . banner-comment)))

(use-package underline-with-char
  :ensure t
  :config (setq-default underline-with-char-fill-char ?=)
  :bind (("C-c t u" . underline-with-char)))

;; this package allows for moving the region to the end of the file for possible re-use.
;; use: palimpsest-mode and C-c C-r
(use-package palimpsest
  :ensure t)

(use-package unidecode
  :ensure t)

(use-package annotate
  :ensure t
  :bind (("C-c a"   . annotate-mode)
	 ("C-c C-a" . annotate-mode)))

(use-package lorem-ipsum
  :ensure t)

;; This changes a lisp command for its output ie:
;; (current-time-string)
;; will be reclaced by the current (incorrectly formatted) time
;; when running M-x lively at the end of the line.
(use-package lively
  :ensure t)

;; Allows editing of text to the left of a bunch of spaces without move the text to the right.
(use-package dynamic-spaces
  :ensure t
  :config
  (dynamic-spaces-global-mode 1))

(use-package hl-todo
  :ensure t
  :config
  (setq-default hl-todo-keyword-faces
                '(("TODO"    . "#FF0000")
                  ("FIXME"   . "#9F40FF")
                  ("CLARIFY" . "#ff8000")))
  (global-hl-todo-mode)
  :bind (("C-c t n" . hl-todo-next)
         ("C-c t p" . hl-todo-previous)))

(use-package string-inflection
  :ensure t
  :bind (("C-c t a" . string-inflection-all-cycle)
         ("C-c t k" . string-inflection-kebab-case)))

(use-package face-explorer
  :ensure t)

(use-package highlight-indent-guides
  :ensure t
  :commands (highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

(global-set-key (kbd "C-c t c") 'comment-box)
(global-set-key (kbd "C-c t t") 'toggle-truncate-lines)
(global-set-key (kbd "C-c t v") 'visual-line-mode)
(global-set-key (kbd "C-c t l") 'linum-mode)
(global-set-key (kbd "C-c t i") 'highlight-indent-guides-mode)
(global-set-key (kbd "C-c t f") 'face-explorer-tooltip-mode)

;; This makes insert overwrite the current selection
(delete-selection-mode 1)

(provide 'iw-text)
;;; iw-text.el ends here
