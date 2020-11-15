;;; iw-bookmark.el --- Setup bookmarks and annotations.  -*- lexical-binding: t; -*-

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

(require 'use-package)

;;; Code:
(use-package bm
  :ensure t
  :demand ; Without demand, the :init section doesn't happen till after something else calls a bm function.
  :init
  (setq bm-restore-repository-on-load t)
  (defun open-bookmarked-buffers ()
    "Open all the files that have bookmarks."
    (interactive)
    (let ((bm-buffers (mapcar 'car bm-repository)))
      (mapc 'find-file-noselect bm-buffers))
    (bm-show-all))
  :config
  (setq bm-electric-show nil)             ; This lets bm-show-all display in a popwin
  (setq-default bm-buffer-persistence t)
  (add-hook 'find-file-hook    #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore)
  (add-hook 'kill-buffer-hook  #'bm-buffer-save)
  (add-hook 'kill-emacs-hook   #'(lambda nil
                                   (bm-buffer-save-all)
                                   (bm-repository-save)))
  :bind (("C-c b m" . bm-toggle)
         ("C-c b t" . bm-toggle)
         ("C-c b l" . bm-show-all)
         ("C-c b s" . bm-show-all)
         ("C-c b a" . bm-show-all)
         ("C-c b p" . bm-previous)
         ("C-c b o" . open-bookmarked-buffers)
         ("C-c b n" . bm-next)))

(provide 'iw-bookmark)
;;; iw-bookmark.el ends here
