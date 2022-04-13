;;; iw-lsp.el ---                                    -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:

(require 'use-package)

;;; Code:

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l"
        gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        lsp-lens-enable t
        lsp-eldoc-enable-hover nil
        lsp-signature-auto-activate nil
        lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
        lsp-completion-enable nil ; uncomment to use cider completion instead of lsp
        )
  :hook ((clojure-mode       . lsp)
         (clojurec-mode      . lsp)
         (clojurescript-mode . lsp)
         (js-mode            . lsp)
         (lsp-mode           . lsp-enable-which-key-integration))
  :config
  (dolist (m '(clojure-mode
               clojurec-mode
               clojurescript-mode
               clojurex-mode))
    (add-to-list 'lsp-language-id-configuration `(,m . "clojure")))
  ;;(setq lsp-clojure-custom-server-command '("bash" "-c" "/opt/homebrew/bin/clojure-lsp"))
  :commands lsp)

;; Don't add this until I can find a way to disable it without having to toggle it in every clojure window.
(use-package lsp-ui
  :ensure t)

(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-origami
  :ensure t)

(provide 'iw-lsp)
;;; iw-lsp.el ends here
