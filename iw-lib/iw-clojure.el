;;; iw-clojure.el --- setup clojure                  -*- lexical-binding: t; -*-

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

;; Modified from emacs-live config.  Putting font-lock-add-keywords into
;; a clojure mode hook means that it gets applied to derived modes too,
;; like clojurescript.

(require 'use-package)

;;; Code:
(use-package clojure-mode
  :ensure t
  :init
  (setq clojure-indent-style :align-arguments)
  (add-hook 'clojure-mode-hook  '(lambda ()
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
                                                     nil)))))))
  :bind (:map clojure-mode-map
              ("C-c c m" . 'clojure-convert-collection-to-map)
              ("C-c c v" . 'clojure-convert-collection-to-vector)
              ("C-c c l" . 'clojure-convert-collection-to-list)
              ("C-c c s" . 'clojure-convert-collection-to-set)
              ("C-c c {" . 'clojure-convert-collection-to-map)
              ("C-c c [" . 'clojure-convert-collection-to-vector)
              ("C-c c '" . 'clojure-convert-collection-to-quoted-list)
              ("C-c c (" . 'clojure-convert-collection-to-list)
              ("C-c c #" . 'clojure-convert-collection-to-set)))

(use-package cider
  :ensure t
  :bind (:map cider-mode-map
              ("M-RET" . 'cider-doc)))

(use-package clj-refactor
  :ensure t
  :init
  (add-hook 'clojure-mode-hook (lambda ()
                                 (clj-refactor-mode 1)
                                 (cljr-add-keybindings-with-prefix "C-c C-r"))))

(use-package cljr-ivy
  :ensure t)

(provide 'iw-clojure)
;;; iw-clojure.el ends here
