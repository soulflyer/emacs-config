;;; iw-text.el --- setup text tools                  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  test

;; Author: test <test@subversion.local>
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

;;; Code:

(use-package banner-comment
  :ensure t
  :bind (("C-c t b" . banner-comment)))

(use-package underline-with-char
  :ensure t
  :config (setq-default underline-with-char-fill-char ?=)
  :bind (("C-c t u" . underline-with-char)))

(use-package annotate
  :ensure t
  :bind (("C-c a"   . annotate-mode)
	 ("C-c C-a" . annotate-mode)))

(global-set-key (kbd "C-c t c") 'comment-box)
(setq indent-tabs-mode nil)

(provide 'iw-text)
;;; iw-text.el ends here
