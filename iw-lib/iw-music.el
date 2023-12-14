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

(use-package emms
  :ensure t
  :config (emms-all)
  (setq emms-source-file-default-directory "~/Music/Collection"
        emms-browser-switch-to-playlist-on-add t
        ;; emms-player-list '(emms-player-vlc emms-player-vlc-playlist)
        ;; emms-player-vlc-command-name "/Applications/VLC.app/Contents/MacOS/VLC"
        ;; emms-player-vlc-playlist-command-name "/Applications/VLC.app/Contents/MacOS/VLC"
        emms-player-list '(emms-player-mpd)
        emms-player-mpd-server-name "localhost"
        emms-player-mpd-server-port "6600"
        emms-player-mpd-music-directory "/Volumes/Collection")
  (add-to-list 'emms-info-functions 'emms-info-mpd)

  :bind (:map emms-browser-mode-map
              ("p"     . emms-playlist-mode-go)
              ("A"     . emms-browser-add-tracks)
              ("C-a"   . emms-browser-add-tracks)
              ("d"     . emms-browser-view-in-dired)
              ("RET"   . emms-browser-toggle-subitems)
              ("<tab>" . emms-browser-next-non-track)))

(provide 'iw-music)
;;; iw-music.el ends here
