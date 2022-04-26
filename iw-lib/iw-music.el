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

;; (define-key org-mode-map (kbd "C-c l") 'iw-lyrics)

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

(provide 'iw-music)
;;; iw-music.el ends here
