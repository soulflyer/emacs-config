;;; iw-music.el --- Setup packages for Music         -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:

;;
(require 'use-package)
;;; Code:

(use-package lyrics
  :ensure t
  :config
  (setq lyrics-backend 'lyrics-azlyrics))

(defun iw-lyrics ()
  "Gets lyrics using the current line."
  (interactive)
  (let ((artist-song (split-string (org-entry-get nil "ITEM") ": ")))
    (lyrics (second artist-song) (first artist-song))))


(defun iw-edit-lyrics ()
  (interactive)
  (let ((song-title (save-excursion
                      (goto-char (point-min))
                      (string-trim (substring (thing-at-point 'line t) 5))))
        (song-artist (save-excursion
                       (goto-char (point-min))
                       (forward-line 1)
                       (string-trim (substring (thing-at-point 'line t) 7)))))
    (lyrics-edit song-artist song-title)))

(define-key lyrics-show-mode-map (kbd "e") 'iw-edit-lyrics)


;; Versuri offers more features for lyrics, but most of them are not interactive.
;; (use-package versuri
;;   :ensure t)

(defun make--covers ()
  (shell-command "convert -resize 60x60   cover.jpg ./cover_small.jpg")
  (shell-command "convert -resize 120x120 cover.jpg ./cover_med.jpg")
  (shell-command "convert -resize 240x240 cover.jpg ./cover_large.jpg")
  (shell-command "convert -resize 480x480 cover.jpg ./cover_huge.jpg"))

(defun make-covers ()
  (message "Make covers in %s" default-directory)
  (let* ((has-cover (directory-files default-directory nil "cover.jpg")))
    (if has-cover (make--covers)
      (message "No cover found"))))

(provide 'iw-music)
;;; iw-music.el ends here
