
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

;; (use-package annotate
;;   :ensure t
;;   :bind (("C-c C-a" . annotate-mode)))

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
                  ("CLARIFY" . "#ff8000")
                  ("IDIOT"   . "#FF88FF")
                  ("NOTE"    . "#40ff40")))
  (global-hl-todo-mode)
  :bind (("C-c t n" . hl-todo-next)
         ("C-c t p" . hl-todo-previous)))

;; This turns boxes made of -|+ into neat drawings using box-drawing unicode chars
;; aa2u-uniform-weight was set to heavy because emacs insisted on using the default
;; font for the light versions of the box drawing chars, even when redefined with
;; unicode-chars.
(use-package ascii-art-to-unicode
  :ensure t
  :config
  (setq aa2u-uniform-weight "LIGHT"))

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

(defun iw-buffer-face-hasklig ()
  "Sets a different font in current buffer for box display"
  (interactive)
  (setq buffer-face-mode-face '(:family "Hasklig" :height 1.1))
  (buffer-face-mode))

(defun iw-buffer-face-default ()
  "Sets the default font in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "MonacoB2"))
  (buffer-face-mode))

(defun iw-space-to-hyphen ()
  (interactive)
  (delete-char 1)
  (insert "-"))

(defun iw-space-to-underbar ()
  (interactive)
  (delete-char 1)
  (insert "_"))

(global-set-key (kbd "C-c t f h") 'iw-buffer-face-hasklig)
(global-set-key (kbd "C-c t f d") 'iw-buffer-face-default)
(global-set-key (kbd "C-c t f s") 'iw-set-font-size)
(global-set-key (kbd "C-c t c")   'comment-box)
(global-set-key (kbd "C-c t t")   'toggle-truncate-lines)
(global-set-key (kbd "C-c t v")   'visual-line-mode)
(global-set-key (kbd "C-c t l")   'display-line-numbers-mode)
(global-set-key (kbd "C-c t i")   'highlight-indent-guides-mode)
(global-set-key (kbd "C-c t h .") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c t h r") 'highlight-regexp)
(global-set-key (kbd "C-c t h u") 'unhighlight-regexp)
(global-set-key (kbd "C-c t h l") 'highlight-lines-matching-regexp)
(global-set-key (kbd "C-c t h p") 'highlight-phrase)
(global-set-key (kbd "C-.")       'iw-space-to-hyphen)
(global-set-key (kbd "C-,")       'iw-space-to-underbar)
;; This makes insert overwrite the current selection
(delete-selection-mode 1)

(provide 'iw-text)
;;; iw-text.el ends here
