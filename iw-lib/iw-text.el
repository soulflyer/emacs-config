;;; iw-text.el --- setup text tools                  -*- lexical-binding: t; -*-
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
;; when running M-x lively at the end of the line. Use M-x lively-stop to revert.
(use-package lively
  :ensure t)

;; Allows editing of text to the left of a bunch of spaces without move the text to the right.
(use-package dynamic-spaces
  :ensure t
  :config
  (dynamic-spaces-global-mode 1))

(use-package hl-todo
  :ensure t
  :demand
  :init
  (setq-default hl-todo-keyword-faces
                '(("TODO"    . "#FF0000")
                  ("FIXME"   . "#9F40FF")
                  ("CLARIFY" . "#ff8000")))
  (global-hl-todo-mode)
  :bind (("C-c t n" . hl-todo-next)
         ("C-c t p" . hl-todo-previous)))

;; This turns boxes made of -|+ into neat drawings using box-drawing unicode chars
;; set to heavy because emacs insists on using the default font for the light versions
;; of the bax drawing chars, even when redefined with unicode-chars
(use-package ascii-art-to-unicode
  :ensure t
  :config
  (setq aa2u-uniform-weight "HEAVY"))

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

(global-set-key (kbd "C-c t c")   'comment-box)
(global-set-key (kbd "C-c t t")   'toggle-truncate-lines)
(global-set-key (kbd "C-c t v")   'visual-line-mode)
(global-set-key (kbd "C-c t l")   'linum-mode)
(global-set-key (kbd "C-c t i")   'highlight-indent-guides-mode)
(global-set-key (kbd "C-c t f")   'face-explorer-tooltip-mode)
(global-set-key (kbd "C-c t h .") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c t h r") 'highlight-regexp)
(global-set-key (kbd "C-c t h u") 'unhighlight-regexp)
(global-set-key (kbd "C-c t h l") 'highlight-lines-matching-regexp)
(global-set-key (kbd "C-c t h p") 'highlight-phrase)

;; This makes insert overwrite the current selection
(delete-selection-mode 1)

(provide 'iw-text)
;;; iw-text.el ends here
