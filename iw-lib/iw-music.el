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

;; TODO add a path parameter
(defun make--covers (path)
  (shell-command (format "convert -resize 60x60   %s/cover.jpg %s/cover_small.jpg" path path))
  (shell-command (format "convert -resize 120x120 %s/cover.jpg %s/cover_med.jpg"   path path))
  (shell-command (format "convert -resize 240x240 %s/cover.jpg %s/cover_large.jpg" path path))
  (shell-command (format "convert -resize 480x480 %s/cover.jpg %s/cover_huge.jpg"  path path)))

;; TODO send a path parameter to make--covers, default to default-directory
(defun make-covers (&optional path)
  "Look for cover.jpg and generate small, medium, large, and huge versions"
  (interactive)
  (let* ((directory (if path
                        path
                      default-directory))
         (has-cover (directory-files directory nil "cover.jpg")))
    (message "Make covers in %s" directory)
    (if has-cover (make--covers directory)
      (message "No cover found"))))

(defun import--music (path)
  (message "Updating mpd db")
  (shell-command "mpc -w update")
  (message "creating covers in %s" path)
  (make-covers path)
  (message "Adding tracks in %s to emms" path)
  (emms-add-directory path))

(defun import-music (&optional path)
  (interactive)
  (let* ((directory (if path
                        path
                      default-directory)))
    (import--music directory)))

(provide 'iw-music)
;;; iw-music.el ends here
