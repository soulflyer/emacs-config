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

(use-package emms
  :ensure t
  :config (emms-all)
  (setq emms-source-file-default-directory "~/Music/Collection"
        emms-browser-switch-to-playlist-on-add t
        ;; emms-player-list '(emms-player-vlc emms-player-vlc-playlist)
        ;; emms-player-vlc-command-name "/Applications/VLC.app/Contents/MacOS/VLC"
        ;; emms-player-vlc-playlist-command-name "/Applications/VLC.app/Contents/MacOS/VLC"
        emms-player-list '(emms-player-mpd)
        emms-info-functions '(emms-info-mpd)
        emms-player-mpd-server-name "localhost"
        emms-player-mpd-server-port "6600"
        emms-player-mpd-music-directory "/Volumes/Collection")
  ;;  (add-to-list 'emms-info-functions 'emms-info-mpd)

  ;; The emms mpd stop function doesn't work. This is lifted from emms.el
  ;; Removing the disconnect fixes the problem.
  (defun stop-mpd ()
    (interactive)
    ;;  (emms-player-mpd-send "stop" nil #'ignore)
    (condition-case nil
        (emms-player-mpd-send "stop" nil #'ignore)
      (error nil))
    ;;(emms-player-mpd-disconnect t)
    (let ((emms-player-stopped-p t))
      (emms-player-stopped)))

  ;; This is lifted from emms-browser-search and would be any easy PR if PRs to
  ;; emms were easy. They are not.
  (defun iw-emms-browser-search (fields &optional search-string)
    "Search for STR using FIELDS."
    (let* ((prompt (format "Searching with %S: " fields))
           (str (or search-string (read-string prompt))))
      (message "Fields: %s, String: %s" fields str)
      (emms-browser-search-buffer-go)
      (emms-with-inhibit-read-only-t
       (emms-browser-render-search
        (emms-browser-filter-cache
         (list (list fields str)))))
      (emms-browser-expand-all)
      (goto-char (point-min))))

  (defun iw-emms-play (play-all)
    "Plays the song, or the whole catalog if ARTIST is not nil, using emms."
    (let* ((artist-song (split-string (org-entry-get nil "ITEM") ": "))
           (artist (second artist-song))
           (track  (first artist-song)))
      (message "Artist: %s" artist)
      (message "Song: %s" track)
      (if play-all
          (iw-emms-browser-search '(info-artist) artist)
        (iw-emms-browser-search '(info-title) track))))

  (defun iw-emms-play-track ()
    "Plays the track on the current line."
    (interactive)
    (iw-emms-play nil))

  (defun iw-emms-play-artist ()
    "Opens a playlist of all the artist on the current lines catalog."
    (interactive)
    (iw-emms-play t))

  :bind (:map
         emms-browser-mode-map
         ("p"      . emms-playlist-mode-go)
         ("a"     . emms-browser-add-tracks)
         ("F"     . emms-show-all)
         ("d"     . emms-browser-view-in-dired)
         ("RET"   . emms-browser-toggle-subitems)
         ("<tab>" . emms-browser-next-non-track)
         :map
         emms-playlist-mode-map
         ("F"     . emms-show-all)))

(provide 'iw-music)
;;; iw-music.el ends here
