;;; iw-bookmark.el --- Setup bookmarks and annotations.  -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;; TODO get rid of persistence here. Using bookmark makes more sense for more permnent
;; bookmarks makes sense. Keep bm for casual use, cleaned out after each restart.
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
