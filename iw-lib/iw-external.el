;;; iw-external.el --- Setup for external searches etc.  -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:
;; TODO Consider howdoi howdoyou asx
(require 'use-package)

;;; Code:

;; Works well but getting the results in an org buffer is just bloody stupid.
;; (use-package howdoyou
;;   :ensure t
;;   :bind (("C-M-]" . howdoyou-next-link)
;;          ("C-M-[" . howdoyou-previous-link)))

;; Old, and google is hardcoded. Maybe not.
;; (use-package howdoi
;;   :ensure t)

;; Painfully slow
;; (use-package asx
;;   :ensure t)

;; Responsive, not sure about the search facility. Also how to access other sites?
(use-package sx
  :ensure t
  :config
  (bind-keys :prefix "C-c x"
             :prefix-map my-sx-map
             :prefix-docstring "Global keymap for SX."
             ("q" . sx-tab-all-questions)
             ("i" . sx-inbox)
             ("o" . sx-open-link)
             ("u" . sx-tab-unanswered-my-tags)
             ("a" . sx-ask)
             ("s" . sx-search)))

;; (use-package hyperspace
;;   :ensure t)

(use-package google-translate
  :ensure t)

;; This is newer and asynchronous, but doesn't seem to work for Vietnamese
(use-package go-translate
  :ensure t
  :config (setq go-translate-target-language "vn"
                go-translate-local-language "en"))

(use-package counsel-web
  :ensure t
  :config
  (setq-default counsel-web-search-action #'browse-url)
  :bind (("C-c w w" . counsel-web-search)
         ("C-c w s" . counsel-web-thing-at-point)))

(provide 'iw-external)
;;; iw-external.el ends here
