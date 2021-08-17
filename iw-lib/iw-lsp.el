;;; iw-lsp.el ---                                    -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Iain Wood

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

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        lsp-lens-enable t
        lsp-eldoc-enable-hover nil
        lsp-signature-auto-activate nil
        ;; lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
        ;; lsp-enable-completion-at-point nil ; uncomment to use cider completion instead of lsp
        lsp-clojure-custom-server-command '("bash" "-c" "/usr/local/bin/clojure-lsp")
        )
  :hook ((clojure-mode . lsp)
         (clojurescript-mode . lsp)
         (js-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (dolist (m '(clojure-mode
               clojurec-mode
               clojurescript-mode
               clojurex-mode))
    (add-to-list 'lsp-language-id-configuration `(,m . "clojure")))
  :commands lsp)


(use-package lsp-ui
  :ensure t)

(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-origami
  :ensure t)

(provide 'iw-lsp)
;;; iw-lsp.el ends here
