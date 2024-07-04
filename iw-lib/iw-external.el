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

(use-package hyperspace
  :ensure t)

(use-package google-translate
  :ensure t
  :config
  (setq google-translate-translation-to-kill-ring t)
  (defun french-to-english ()
    "Set to and from languages for google translate."
    (interactive)
    (setq google-translate-default-source-language "fr")
    (setq google-translate-default-target-language "en"))
  (defun vietnamese-to-english ()
    "Set to and from languages for google translate."
    (interactive)
    (setq google-translate-default-source-language "vn")
    (setq google-translate-default-target-language "en")))

;; This is newer and asynchronous, but doesn't seem to work for Vietnamese
;; (use-package go-translate
;;   :ensure t
;;   :config (setq gts-translate-list '(("en" "vn"))))

(use-package counsel-web
  :ensure t
  :config
  (setq-default counsel-web-search-action #'browse-url)
  :bind (("C-c w w" . counsel-web-search)
         ("C-c w s" . counsel-web-thing-at-point)))

(defun browse-eww ()
  "Set `browse-url-browser-function` to `eww`."
  (interactive)
  (message "Setting 'eww' as default browser")
  (setq browse-url-browser-function 'eww))

(defun browse-default ()
  "Set `browse-url-browser-function` to `browse-url-default-macosx-browser`."
  (interactive)
  (message "Setting 'default' as default browser")
  (setq browse-url-browser-function 'browse-url-default-macosx-browser))

(defun browse-webkit ()
  "Set `browse-url-browser-function` to `xwidget-webkit-browse-url`."
  (interactive)
  (message "Setting 'webkit' as default browser")
  (setq browse-url-browser-function 'xwidget-webkit-browse-url))

(defun iw-open-external ()
  "View the current file in an external program."
  (interactive)
  (shell-command (concat "open \"" (buffer-file-name) "\"")))

(setq browse-url-browser-function 'browse-url-default-macosx-browser)

(provide 'iw-external)
;;; iw-external.el ends here
