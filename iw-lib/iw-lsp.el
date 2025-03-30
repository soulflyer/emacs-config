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
        lsp-lens-enable t
        lsp-eldoc-enable-hover t
        lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
        lsp-completion-enable nil ; uncomment to use cider completion instead of lsp
        ;; lsp-log-io t
        )
  :hook ((clojure-mode       . lsp)
         (clojurec-mode      . lsp)
         (clojurescript-mode . lsp)
         (js-mode            . lsp)
         (lsp-mode           . lsp-enable-which-key-integration)
         (python-mode        . lsp))
  ;;(setq lsp-clojure-custom-server-command '("bash" "-c" "/opt/homebrew/bin/clojure-lsp"))
  :commands lsp)

;; Don't add this until I can find a way to disable it without having to toggle it in every clojure window.
(use-package lsp-ui
  :ensure t
  :init
  (setq lsp-ui-doc-alignment 'frame
        lsp-ui-doc-delay 0.5
        lsp-ui-doc-enable t
        lsp-ui-doc-header t
        lsp-ui-doc-max-width 100
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-use-childframe t)
  :config
  (bind-keys :prefix "C-c l"
             :prefix-map my-lsp-ui-map
             ("d" . lsp-describe-thing-at-point)
             ("t" . lsp-treemacs-symbols))
  :commands lsp-ui-mode)

(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-origami
  :ensure t)

(use-package lsp-treemacs
  :ensure t)

(provide 'iw-lsp)
;;; iw-lsp.el ends here
