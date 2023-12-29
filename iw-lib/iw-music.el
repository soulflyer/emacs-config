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
  (setq emms-source-file-default-directory "/Volumes/Collection"
        emms-browser-switch-to-playlist-on-add t
        ;; emms-player-list '(emms-player-vlc emms-player-vlc-playlist)
        ;; emms-player-vlc-command-name "/Applications/VLC.app/Contents/MacOS/VLC"
        ;; emms-player-vlc-playlist-command-name "/Applications/VLC.app/Contents/MacOS/VLC"
        emms-player-list '(emms-player-mpd)
        emms-info-functions '(emms-info-native
                              emms-info-cueinfo
                              emms-info-mpd)
        emms-mode-line-titlebar-function '(lambda nil (concat "🎵" (emms-mode-line-playlist-current)))
        emms-player-mpd-server-name "127.0.0.1"
        emms-player-mpd-server-port "6600"
        emms-player-mpd-music-directory "/Volumes/Collection"
        emms-playlist-default-major-mode 'emms-mark-mode
        ;;emms-mode-line-titlebar-function 'ignore
        ;;emms-player-mpd-verbose t
        emms-player-mpd
        '(*player* (start . emms-player-mpd-start) (stop . stop-mpd)
                   (playablep . emms-player-mpd-playable-p)
                   (regex .
                          "\\(\\.\\(m3u\\|pls\\|\\(?:16sv\\|3g[2p]\\|4xm\\|8svx\\|a\\(?:a[3c]\\|c3\\|dx\\|fc\\|if[cf]?\\|law\\|mr\\|nim\\|p[ce]\\|sf\\|trac\\|ud\\|v\\(?:m2\\|[is]\\)\\|[lu]\\)\\|b\\(?:ap\\|fi\\)\\|c\\(?:93\\|a[fk]\\|in\\|mv\\|pk\\)\\|d\\(?:aud\\|ct\\|ff\\|ivx\\|sf\\|ts\\|vd?\\|xa\\)\\|eac3\\|f\\(?:ilm\\|l\\(?:ac\\|[cilvx]\\)\\)\\|g\\(?:726\\|sm\\|xf\\)\\|htk\\|i\\(?:ff\\|ss\\)\\|m\\(?:1v\\|2\\(?:ts\\|[tv]\\)\\|4[abv]\\|ad\\|id\\|j\\(?:2\\|p\\(?:e?g\\)\\)\\|k[av]\\|lp\\|mf?\\|ov\\|p\\(?:eg\\|ga\\|[+1-4cgpu]\\)\\|v[ei]\\|xf\\)\\|n\\(?:c\\|sv\\|u[tv]\\)\\|o\\(?:g[agmvx]\\|m[ag]\\|pus\\)\\|p\\(?:af\\|sp\\|v[af]\\)\\|q\\(?:cp\\|t\\)\\|r\\(?:3d\\|am\\|l2\\|mvb\\|oq\\|pl\\|t\\(?:\\(?:p\\|sps?\\)://\\)\\|vc\\|[am]\\)\\|s\\(?:d2\\|f\\|hn\\|mk\\|nd\\|o[ln]\\|px\\|tr\\|vx\\|wf\\)\\|t\\(?:ak\\|g[iqv]\\|hp\\|sp?\\|ta\\)\\|uv2?\\|v\\(?:b\\|id\\|md\\|o[bc]\\|p6\\)\\|w\\(?:64\\|av\\|ebm\\|m[av]\\|s\\(?:aud\\|vga\\)\\|ve?\\)\\|x\\(?:vid\\|[ai]\\)\\)\\)\\'\\)\\|\\(\\`\\(?:Other\\|f\\(?:eatures:\\|tp\\(?:s?://\\)\\)\\|gopher://\\|h\\(?:\\(?:ls\\+https?\\|ttps?\\)://\\)\\|i\\(?:cu\\|pv6\\)\\|mms\\(?:[ht]://\\)\\|nfs://\\|rt\\(?:\\(?:mp\\(?:ts\\|[st]\\)?\\|p\\|sps?\\)://\\)\\|s\\(?:\\(?:mb\\|rtp\\)://\\)\\|tcp\\|un\\)\\)")
                   (pause . emms-player-mpd-pause)
                   (resume . emms-player-mpd-pause)
                   (seek . emms-player-mpd-seek)
                   (seek-to . emms-player-mpd-seek-to)))
  ;;  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (defun emms-short-modeline ()
    (message "running playlist mode hook")
    (setq mode-line-format '("%e"
                             mode-line-misc-info
                             mode-line-buffer-identification
                             mode-line-end-spaces)
          global-mode-string '(""
                               emms-playing-time-string
                               emms-mode-line-string)))

  (add-hook 'emms-playlist-mode-hook 'emms-short-modeline)
  (add-hook 'emms-browser-mode-hook 'emms-short-modeline)
  
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
      (emms-browser-search-buffer-go)
      (emms-with-inhibit-read-only-t
       (emms-browser-render-search
        (emms-browser-filter-cache
         (list (list fields str)))))
      (emms-browser-expand-all)
      (goto-char (point-min))))

  (defun iw-emms-play (play-all)
    "Passes the song to emms, or the whole catalog if ARTIST is not nil."
    (let* ((artist-song (split-string (org-entry-get nil "ITEM") ": "))
           (artist (second artist-song))
           (track  (first artist-song)))
      (if play-all
          (iw-emms-browser-search '(info-artist) artist)
        (iw-emms-browser-search '(info-title) track))))

  (defun iw-emms-play-track ()
    "Opens an emms playlist with all tracks that match the title on the current line."
    (interactive)
    (iw-emms-play nil))

  (defun iw-emms-play-artist ()
    "Opens an emms playlist containing all the artists catalog."
    (interactive)
    (iw-emms-play t))

  (defun iw-emms-info-track-description (track)
    "Return a description of TRACK."
    (let ((artist (emms-track-get track 'info-artist))
          (title  (emms-track-get track 'info-title)))
      (cond
       ((and artist title)
        (concat artist " : " title))
       (title
        title)
       (t
        (emms-track-simple-description track)))))

  (advice-add 'emms-info-track-description :override 'iw-emms-info-track-description)

  (defun iw-emms-browser-format-line (bdata &optional target)
    "Return a propertized string to be inserted in the buffer."
    (unless target
      (setq target 'browser))
    (let* ((name (or (emms-browser-bdata-name bdata) "misc"))
           (level (emms-browser-bdata-level bdata))
           (type (emms-browser-bdata-type bdata))
           (indent (emms-browser-make-indent level))
           (track (emms-browser-bdata-first-track bdata))
           (path (emms-track-get track 'name))
           (face (emms-browser-get-face bdata))
           (format (emms-browser-get-format bdata target))
           (props (list 'emms-browser-bdata bdata))
           (format-choices
            `(("i" . ,indent)
              ("n" . ,name)
              ("y" . ,(emms-track-get-year track))
              ("A" . ,(emms-track-get track 'info-album))
              ("a" . ,(emms-track-get track 'info-artist))
              ("C" . ,(emms-track-get track 'info-composer))
              ("p" . ,(emms-track-get track 'info-performer))
              ("t" . ,(emms-track-get track 'info-title))
	      ("D" . ,(emms-browser-disc-number track))
              ("T" . ,(emms-browser-track-number track))
              ("d" . ,(emms-browser-track-duration track))))
	   str)
      (when (equal type 'info-album)
        (setq format-choices (append format-choices
                                     `(("cS" . ,(emms-browser-get-cover-str path 'small))
                                       ("cM" . ,(emms-browser-get-cover-str path 'medium))
                                       ("cL" . ,(emms-browser-get-cover-str path 'large))))))


      (when (functionp format)
        (setq format (funcall format bdata format-choices)))

      (setq str
            (with-temp-buffer
              (insert format)
              (goto-char (point-min))
              (let ((start (point-min)))
                ;; jump over any image
                (when (re-search-forward "%c[SML]" nil t)
                  (setq start (point)))
                ;; jump over the indent
                (when (re-search-forward "%i" nil t)
                  (setq start (point)))
                (add-text-properties start (point-max)
                                     (list 'face face)))
              (buffer-string)))

      (setq str (emms-browser-format-spec str format-choices))

      ;; give tracks a 'boost' if they're not top-level
      ;; (covers take up an extra space)
      (when (and (eq type 'info-title)
                 (not (string= indent "")))
        (setq str (concat " " str)))

      ;; if we're in playlist mode, add a track
      (when (and (eq target 'playlist)
                 (eq type 'info-title))
        (setq props
              (append props `(emms-track ,track))))

      ;; add properties to the whole string
      (add-text-properties 0 (length str) props str)
      str))

  ;;(advice-add 'emms-browser-format-line :override 'iw-emms-browser-format-line)
  
  :bind (:map
         emms-browser-mode-map
         ("p"     . emms-playlist-mode-go)
         ("a"     . emms-browser-add-tracks)
         ("F"     . emms-show-all)
         ("d"     . emms-browser-view-in-dired)
         ("RET"   . emms-browser-toggle-subitems)
         ("<tab>" . emms-browser-next-non-track)
         :map
         emms-playlist-mode-map
         ("F"     . emms-show-all)
         ("SPC"   . emms-pause)
         ("."     . emms-seek-forward)
         (","     . emms-seek-backward)))

(provide 'iw-music)
;;; iw-music.el ends here
