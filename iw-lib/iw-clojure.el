;;; iw-clojure.el --- setup clojure                  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Iain Wood

;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;; Modified from emacs-live config.  Putting font-lock-add-keywords into
;; a clojure mode hook means that it gets applied to derived modes too,
;; like clojurescript.

;;; Code:
(require 'use-package)
;;(require 'cljstyle-mode)
;; (require 'cider-storm)
;; (define-key cider-mode-map (kbd "C-c C-f") 'cider-storm-map)

(use-package clojure-mode
  :ensure t
  :init
  (setq clojure-indent-style :align-arguments)
  (add-hook 'clojure-mode-hook  #'(lambda ()
                                    (font-lock-add-keywords
                                     nil `(("(\\(fn\\)[\[[:space:]]"
                                            (0 (progn (compose-region (match-beginning 1)
                                                                      (match-end 1) "λ")
                                                      nil)))))
                                    (font-lock-add-keywords
                                     nil `(("\\(#\\)("
                                            (0 (progn (compose-region (match-beginning 1)
                                                                      (match-end 1) "ƒ")
                                                      nil)))))
                                    (font-lock-add-keywords
                                     nil `(("\\(#\\){"
                                            (0 (progn (compose-region (match-beginning 1)
                                                                      (match-end 1) "∈")
                                                      nil)))))
                                    ;; (setq indent-line-function `cljstyle)
                                    ))
  ;; I don't like this. Call cljstyle-format-buffer by hand instead
  ;;(add-hook 'clojure-mode-hook 'cljstyle-format-on-save-mode)
  :config
  :bind (("C-c C-x C-j j"   . 'cider-jack-in-clj)
         ("C-c C-x C-j C-j" . 'cider-jack-in-clj)
         ("C-c C-x C-j s"   . 'cider-jack-in-cljs)
         ("C-c C-x C-j C-s" . 'cider-jack-in-cljs)
         ("C-c C-x C-j RET" . 'cider-jack-in-clj&cljs)
         :map clojure-mode-map
         ;;("TAB"           . 'indent-region)
         ("TAB"             . 'cljstyle-format-buffer)
         ("C-c c m"         . 'clojure-convert-collection-to-map)
         ("C-c c v"         . 'clojure-convert-collection-to-vector)
         ("C-c c l"         . 'clojure-convert-collection-to-list)
         ("C-c c s"         . 'clojure-convert-collection-to-set)
         ("C-c c {"         . 'clojure-convert-collection-to-map)
         ("C-c c ["         . 'clojure-convert-collection-to-vector)
         ("C-c c '"         . 'clojure-convert-collection-to-quoted-list)
         ("C-c c ("         . 'clojure-convert-collection-to-list)
         ("C-c c #"         . 'clojure-convert-collection-to-set)
         ("C-c a"           . 'align-cljlet)
         ("M-RET"           . 'lsp-describe-thing-at-point)))

(use-package cider
  :ensure t
  :bind (:map cider-repl-mode-map
              ("M-RET" . 'cider-doc)
              ("C-c q" . 'cider-quit)
              ("C-c h" . 'cider-browse-ns-all)
              ("S-<up>"   . 'cider-repl-previous-input)
              ("S-<down>" . 'cider-repl-next-input))
  :init
  (add-hook 'cider-repl-mode-hook #'(lambda () (setq scroll-conservatively 101)))
  :config (setq cider-eldoc-display-for-symbol-at-point t
                cider-use-tooltips nil
                cider-debug-prompt 'minibuffer))

(use-package align-cljlet
  :ensure t)

;; (use-package clj-refactor
;;   :ensure t
;;   :init
;;   (add-hook 'clojure-mode-hook (lambda ()
;;                                  (clj-refactor-mode 1)
;;                                  (cljr-add-keybindings-with-prefix "C-c C-r")))
;;   :config
;;   ;; There are 2 things trying to add ns defns. No idea what the other is so turn this one off
;;   (setq cljr-add-ns-to-blank-clj-files nil))

(use-package inf-clojure
  :ensure t)

;; (use-package cljr-ivy
;;   :ensure t)

(use-package neil
  :ensure t
  :config
  (setq neil-prompt-for-version-p nil
        neil-inject-dep-to-project-p t))

;;(require 're-jump)
;;(global-set-key (kbd "M->") 're-frame-jump-to-reg)

(use-package cljstyle-format
  :ensure t)

(provide 'iw-clojure)
;;; iw-clojure.el ends here
