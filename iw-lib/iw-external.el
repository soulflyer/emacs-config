;;; iw-external.el --- Setup for external searches etc.  -*- lexical-binding: t; -*-

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

;; This does the same thing as nvALT and can share notes
(use-package deft
  :ensure t
  :config
  (setq deft-use-filename-as-title t
        deft-use-filter-string-for-filename t))

;; (use-package hyperspace
;;   :ensure t)

(use-package google-translate
  :ensure t)

;; This is newer and asynchronous, but doesn't seem to work for Vietnamese
;; (use-package go-translate
;;   :ensure t
;;   :config (setq go-translate-target-language "vn"
;;                 go-translate-local-language "en"))

(use-package counsel-web
  :ensure t
  :config
  (setq-default counsel-web-search-action #'browse-url)
  :bind (("C-c w w" . counsel-web-search)
         ("C-c w s" . counsel-web-thing-at-point)))

(use-package lyrics
  :ensure t)

(defun iw-lyrics ()
  "Gets lyrics using the current line."
  (interactive)
  (let ((artist-song (split-string (org-entry-get nil "ITEM") ": ")))
    (lyrics (second artist-song) (first artist-song))))

;;(define-key org-mode-map (kbd "C-c l") 'iw-lyrics)

;; Versuri offers more features for lyrics, but most of them are not interactive.
;; (use-package versuri
;;   :ensure t)

(provide 'iw-external)
;;; iw-external.el ends here
