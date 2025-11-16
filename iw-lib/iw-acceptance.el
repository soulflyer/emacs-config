;;; iw-acceptance.el ---                             -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Iain Wood

;; Author: Iain Wood <iain@acceptance.local>
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

;; Not even sure if this works yet, as this file will be run before lsp
;; is required. However it works when running it by hand.

;;; Code:

(setq lsp-clojure-server-command '("/opt/homebrew/bin/clojure-lsp")
      org-ditaa-jar-path "/opt/homebrew/Cellar/ditaa/0.11.0_1/libexec/ditaa-0.11.0-standalone.jar"
      org-attach-screenshot-command-line "screencapture -i %f")

(provide 'iw-acceptance)
;;; iw-acceptance.el ends here
