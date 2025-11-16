;;; iw-emms.el --- emms setup and modifications      -*- lexical-binding: t; -*-
;; Copyright (C) 2025  iain
;; Author: iain <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(use-package emms
  :ensure t
  :config (emms-all)
  (setq emms-source-file-default-directory "~/Music/Collection"
        emms-browser-switch-to-playlist-on-add t
        emms-player-list '(emms-player-mpd)
        emms-info-functions '(;;emms-info-native
                              ;;emms-info-cueinfo
                              ;;emms-info-mpd
                              emms-info-exiftool
                              )
        emms-mode-line-titlebar-function '(lambda nil (concat "🎵" (emms-mode-line-playlist-current)))
        emms-player-mpd-server-name "127.0.0.1"
        emms-player-mpd-server-port "6600"
        emms-player-mpd-music-directory "~/Music/Collection"
        emms-playlist-default-major-mode 'emms-mark-mode
        emms-last-played-keep-count nil
        emms-player-mpd
        '(*player* (start . emms-player-mpd-start)
                   (stop . emms-player-mpd-stop)
                   (playablep . emms-player-mpd-playable-p)
                   (regex
                    .
                    "\\(\\.\\(m4a\\|m3u\\|pls\\|\\(?:16sv\\|3g[2p]\\|4xm\\|8svx\\|a\\(?:a[3c]\\|c3\\|dx\\|fc\\|if[cf]?\\|law\\|mr\\|nim\\|p[ce]\\|sf\\|trac\\|ud\\|v\\(?:m2\\|[is]\\)\\|[lu]\\)\\|b\\(?:ap\\|fi\\)\\|c\\(?:93\\|a[fk]\\|in\\|mv\\|pk\\)\\|d\\(?:aud\\|ct\\|ff\\|ivx\\|sf\\|ts\\|vd?\\|xa\\)\\|eac3\\|f\\(?:ilm\\|l\\(?:ac\\|[cilvx]\\)\\)\\|g\\(?:726\\|sm\\|xf\\)\\|htk\\|i\\(?:ff\\|ss\\)\\|m\\(?:1v\\|2\\(?:ts\\|[tv]\\)\\|4[abv]\\|ad\\|id\\|j\\(?:2\\|p\\(?:e?g\\)\\)\\|k[av]\\|lp\\|mf?\\|ov\\|p\\(?:eg\\|ga\\|[+1-4cgpu]\\)\\|v[ei]\\|xf\\)\\|n\\(?:c\\|sv\\|u[tv]\\)\\|o\\(?:g[agmvx]\\|m[ag]\\|pus\\)\\|p\\(?:af\\|sp\\|v[af]\\)\\|q\\(?:cp\\|t\\)\\|r\\(?:3d\\|am\\|l2\\|mvb\\|oq\\|pl\\|t\\(?:\\(?:p\\|sps?\\)://\\)\\|vc\\|[am]\\)\\|s\\(?:d2\\|f\\|hn\\|mk\\|nd\\|o[ln]\\|px\\|tr\\|vx\\|wf\\)\\|t\\(?:ak\\|g[iqv]\\|hp\\|sp?\\|ta\\)\\|uv2?\\|v\\(?:b\\|id\\|md\\|o[bc]\\|p6\\)\\|w\\(?:64\\|av\\|ebm\\|m[av]\\|s\\(?:aud\\|vga\\)\\|ve?\\)\\|x\\(?:vid\\|[ai]\\)\\)\\)\\'\\)\\|\\(\\`\\(?:Other\\|f\\(?:eatures:\\|tp\\(?:s?://\\)\\)\\|gopher://\\|h\\(?:\\(?:ls\\+https?\\|ttps?\\)://\\)\\|i\\(?:cu\\|pv6\\)\\|mms\\(?:[ht]://\\)\\|nfs://\\|rt\\(?:\\(?:mp\\(?:ts\\|[st]\\)?\\|p\\|sps?\\)://\\)\\|s\\(?:\\(?:mb\\|rtp\\)://\\)\\|tcp\\|un\\)\\)")
                   (pause . emms-player-mpd-pause)
                   (resume . emms-player-mpd-pause)
                   (seek . emms-player-mpd-seek)
                   (seek-to . emms-player-mpd-seek-to)))

  (defun emms-short-modeline ()
    (message "running playlist mode hook")
    (setq mode-line-format '("%e"
                             mode-line-misc-info
                             mode-line-buffer-identification
                             mode-line-end-spaces)
          global-mode-string '(""
                               emms-playing-time-string
                               emms-mode-line-string)))

  (defun emms-mpd-crop ()
    (shell-command "mpc crop")
    (message "Cropped mpd playlist"))

  (add-hook 'emms-playlist-mode-hook 'emms-short-modeline)
  (add-hook 'emms-browser-mode-hook 'emms-short-modeline)
  (add-hook 'emms-playlist-cleared-hook 'emms-mpd-crop)

  ;; These 2 functions are necessary because the emms-seek functions cause the playback to stop,
  ;; at least on Linux. Pausing and unpausing gets it going again.
  ;; TODO check periodically to see if this is still the case.
  (defun emms-skip-forward ()
    (interactive)
    (emms-pause)
    (emms-seek-forward)
    (emms-pause))

  (defun emms-skip-backward ()
    (interactive)
    (emms-pause)
    (emms-seek-backward)
    (emms-pause))
  
  (defun trim-track-name (name)
    "Remove the first parts of the path and the leading slash leaving only artist/album/track."
    (string-trim-left
     name
     (concat (expand-file-name emms-player-mpd-music-directory) "/")))
  
  (defun stats-db-play-count (track)
    (let ((count))
      (condition-case nil
          (setq count (first
                       (first
                        (sqlite-execute
                         (sqlite-open "~/.config/mpd/stats.db")
                         (format
                          "SELECT play_count FROM song WHERE uri=\"%s\""
                          (trim-track-name (emms-track-get track 'name)))))))
        (error 0))
      (if (and (numberp count) (< 0 count))
          count)))

  (defun get-current-track-play-count ()
    (interactive)
    (message
     (format "Play count of %s is: %d"
             (emms-track-get (emms-playlist-current-selected-track) 'info-title)
             (stats-db-play-count (emms-playlist-current-selected-track)))))

  (defun emms-sticker-db-comments (track)
    (let* ((name (trim-track-name (emms-track-get track 'name)))
           (comments (shell-command-to-string (concat "mpc sticker \"" name "\" get comment"))))
      (if (not (string-prefix-p "MPD error" comments))
          (s-trim (string-trim-left comments "comment=")))))

  (defun emms-set-sticker-db-comments (track comment)
    (let* ((name (trim-track-name (emms-track-get track 'name))))
      (shell-command-to-string (concat "mpc sticker \"" name "\" set comment " comment))
      (message (format "Set comments of %s to %s" name comment))))

  (defun emms-comment ()
    (interactive)
    (let* ((track (emms-browser-bdata-first-track (emms-browser-bdata-at-point)))
           (old-comment (emms-sticker-db-comments track))
           (comment (concat "\"" (read-string "Comment: " old-comment) "\"")))
      (emms-set-sticker-db-comments track comment)))

  
  (defun stars (n)
    "Returns a string representing a rating from 0-5 stars, including halves."
    (let* ((star "🔶")
           (half-star (if (= 1 n)
                          "🔹"
                        "🔸"))
           (whole (floor (/ n 2)))
           (half (ceiling (- n (* 2 whole))))
           (output-format ""))
      (dotimes (number whole output-format)
        (setq output-format (concat "%1$s" output-format)))
      (if (> half 0)
          (setq output-format (concat "%2$s" output-format)))
      (format output-format star half-star)))

  (defun emms-love ()
    (interactive)
    (let* ((track (emms-browser-bdata-first-track (emms-browser-bdata-at-point)))
           (old-comment (emms-sticker-db-comments track))
           (loved (string-prefix-p "🩷" old-comment))
           (comment (if loved
                        (concat "\"" (substring old-comment 1 nil) "\"")
                      (concat "\"🩷" old-comment "\""))))
      (emms-set-sticker-db-comments track comment)
      (message (format "Set comment to %s - %S" comment loved))))

  (defun emms-sticker-db-rating (track)
    (let* ((name (trim-track-name (emms-track-get track 'name)))
           (rating-string (shell-command-to-string (concat "mpc sticker \""  name "\" get rating")))
           (rating (string-to-number (string-trim-left rating-string "rating="))))
      rating))

  (defun emms-set-sticker-db-rating (track n)
    (let* ((name (trim-track-name (emms-track-get track 'name)))
           (rating (number-to-string n)))
      (shell-command-to-string (concat "mpc sticker \"" name "\" set rating " rating))
      (format "Set rating of %s to %s" name (stars n))))

  (defun emms-sticker-db-playcount (track)
    (let* ((name (trim-track-name (emms-track-get track 'name)))
           (playcount-string (shell-command-to-string (concat "mpc sticker \""  name "\" get playcount")))
           (playcount (string-to-number (string-trim-left playcount-string "playcount="))))
      playcount))
  
  (defun emms-rate ()
    (interactive)
    (let ((track (emms-browser-bdata-first-track (emms-browser-bdata-at-point)))
          (rating (read-number "Rating (number of half stars): ")))
      (emms-set-sticker-db-rating track rating)))

  (defun iw-emms-browser-format-line (bdata &optional target)
    "Return a propertized string to be inserted in the buffer.
     Lifted from emms-browser.el, emms-browser-format-line.
     Adds ability to specify play-count, rating, and comment."
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
           ;; ***** The following 3 are added *************
           (playcount (emms-sticker-db-playcount track))
           (comments (emms-sticker-db-comments track))
           (rating     (stars (emms-sticker-db-rating track)))
           ;; *********************************************
           (format-choices
            `(("i" . ,indent)
              ("n" . ,name)
              ;; The following 3 are added
              ("c" . ,playcount)
              ("k" . ,comments)
              ("r" . ,rating)
              ;; *************************
              ("y" . ,(emms-track-get-year track))
              ("A" . ,(emms-track-get track 'info-album))
              ("a" . ,(emms-track-get track 'info-artist))
              ("o" . ,(emms-track-get track 'info-albumartist))
              ("C" . ,(emms-track-get track 'info-composer))
              ("p" . ,(emms-track-get track 'info-performer))
              ("t" . ,(emms-track-get track 'info-title))
              ("g" . ,(emms-track-get track 'info-genre))
	      ("D" . ,(emms-browser-disc-number track))
              ("T" . ,(emms-browser-track-number track))
              ("d" . ,(emms-browser-track-duration track))))
	   str)
      (when (equal type 'info-album)
        (setq format-choices
              (append format-choices
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

  (advice-add 'emms-browser-format-line :override 'iw-emms-browser-format-line)

  (defun iw-emms-browser-track-artist-and-title-format (_bdata fmt)
    (let ((comment (emms-browser-format-elem fmt "k")))
      (concat
       (let ((track (emms-browser-format-elem fmt "T")))
         (if (and track (not (string= track "0")))
             "%2.2T "
           "  "))
       "%5d "
       (let ((playcount (emms-browser-format-elem fmt "c")))
         (if (and playcount (not (= playcount 0)))
             "🔊%-3.3c"
           "     "))
       (if (and comment (not (string= comment "")))
           (if (string-prefix-p "🩷" comment)
               "🩷"
             "  ")
         "  ")
       "%10r %-36.35t"
       (if comment
           (if (string-prefix-p "🩷" comment)
               (if (> 1 (length comment))
                   (concat "🫧" (substring comment 1 nil))
                 "")
             (concat "🫧" comment))))))

  (advice-add 'emms-browser-track-artist-and-title-format :override 'iw-emms-browser-track-artist-and-title-format)

  (defun iw-emms-browser-year-and-album-fmt (_bdata fmt)
    (concat
     "%i%cL"
     (let ((year (emms-browser-format-elem fmt "y")))
       (if (and year (not (string= year "0")))
           "(%y) "
         ""))
     "%n%i🎹 %g%i"
     (let ((comment (emms-browser-format-elem fmt "k")))
       (if (and comment (not (string= comment "")))
           (concat " 🫧" (if (string-prefix-p "🩷" comment)
                             (substring comment 1 nil)
                           comment))
         ""))))

  (advice-add 'emms-browser-year-and-album-fmt :override 'iw-emms-browser-year-and-album-fmt)

  ;; This is old code lifted from EMMS. There may be a better way to search for all tracks
  ;; by a given artist, but I can't find one that doesn't mean I have to wait while the
  ;; library is reloaded after I'm finished. This way uses a separate buffer so it allows
  ;; me to go instantly back to the full list of bands by pressing Q
  (defun emms-browser-matches-p (track search-list)
    (let (no-match matched)
      (dolist (item search-list)
        (setq matched nil)
        (dolist (field (car item))
          (let ((track-field (emms-track-get track field "")))
            (when (and track-field (string-match (cadr item) track-field))
              (setq matched t))))
        (unless matched
          (setq no-match t)))
      (not no-match)))

  (defun emms-browser-render-search (tracks)
    (let ((entries
           (emms-browser-make-sorted-alist 'info-artist tracks)))
      (dolist (entry entries)
        (emms-browser-insert-top-level-entry (car entry)
                                             (cdr entry)
                                             'info-artist))))

  (defun emms-browser-filter-cache (search-list)
    "Return a list of tracks that match SEARCH-LIST.
SEARCH-LIST is a list of cons pairs, in the form:

  ((field1 field2) string)

If string matches any of the fields in a cons pair, it will be
included."

    (let (tracks)
      (maphash (lambda (_k track)
                 (when (emms-browser-matches-p track search-list)
                   (push track tracks)))
               emms-cache-db)
      tracks))
  
  (defun emms-browser-search-buffer-go ()
    "Create a new search buffer, or clean the existing one."
    (switch-to-buffer
     (get-buffer-create "*emms-browser-search*"))
    (emms-browser-mode t)
    ;;(use-local-map emms-browser-search-mode-map)
    (emms-with-inhibit-read-only-t
     (delete-region (point-min) (point-max))))
  
  (defun emms-browser-search-noninteractive (fields str)
    "Search for STR using FIELDS."
    (emms-browser-search-buffer-go)
    (emms-with-inhibit-read-only-t
     (emms-browser-render-search
      (emms-browser-filter-cache
       (list (list fields str)))))
    (emms-browser-expand-all)
    (goto-char (point-min)))

  (defun emms-browser-search-by-artist-at-point ()
    (interactive)
    (emms-browser-search-noninteractive
     '(info-artist)
     (emms-track-get
      (emms-browser-bdata-first-track
       (emms-browser-bdata-at-point))
      'info-artist)))

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

  ;; (defun emms-browser-filter-rating (rating)
  ;;   (lambda (track)
  ;;     (< (funcall 'emms-sticker-db-rating track) rating)))

  ;; (emms-browser-make-filter "5-star"           (emms-browser-filter-rating 10))
  ;; (emms-browser-make-filter "4-star"           (emms-browser-filter-rating 8))
  ;; (emms-browser-make-filter "since-yesterday"  (emms-browser-filter-only-recent 2))
  ;; (emms-browser-make-filter "this-week"        (emms-browser-filter-only-recent 7))
  ;; (emms-browser-make-filter "this-month"       (emms-browser-filter-only-recent 31))
  ;; (emms-browser-make-filter "this-year"        (emms-browser-filter-only-recent 365))
  ;; (emms-browser-make-filter "all"              'ignore)
  ;; (emms-browser-set-filter (assoc "all" emms-browser-filters))

  ;; ;; Add the stored playlists
  ;; ;; TODO read all the saved playlists instead of manually specifying each one
  ;; (emms-playlist-new)
  ;; (emms-playlist-new-from-saved "5-star")
  ;; (emms-playlist-new-from-saved "4-star")
  ;; (emms-playlist-new-from-saved "working-on")
  ;; (emms-playlist-new-from-saved "Candidates")

  ;; (keymap-unset emms-browser-mode-map "E")
  ;; (keymap-unset emms-browser-mode-map "2")
  ;; (keymap-unset emms-browser-mode-map "3")
  ;; (keymap-unset emms-browser-mode-map "4")

  ;; (global-set-key [f7] 'emms-seek-backward)
  ;; (global-set-key [f9] 'emms-seek-forward)

  :bind (("<f7>"  . emms-skip-backward)
         ("<f9>"  . emms-skip-forward)
         :map
         emms-browser-mode-map
         ("p"     . emms-playlist-mode-go)
         ("a"     . emms-browser-add-tracks)
         ("F"     . emms-show-all)
         ("d"     . emms-browser-view-in-dired)
         ("RET"   . emms-browser-toggle-subitems)
         ("<tab>" . emms-browser-next-non-track)
         ("C-s"   . consult-line)
         ("SPC"   . emms-pause)
         ("A"     . emms-browser-search-by-artist-at-point)
         ("r"     . emms-rate)
         ("c"     . emms-comment)
         ("R"     . emms-browser-goto-random)
         ("l"     . emms-love)
         ("f a"   . emms-browser-show-all)
         ("f y"   . emms-browser-show-since-yesterday)
         ("f 4"   . emms-browser-show-4-star)
         ("f 5"   . emms-browser-show-5-star)
         ("f w"   . emms-browser-show-this-week)
         ("f m"   . emms-browser-show-this-month)
         ("f y"   . emms-browser-show-this-year)
         :map
         emms-playlist-mode-map
         ("F"     . emms-show-all)
         ("SPC"   . emms-pause)
         ("."     . emms-skip-forward)
         (","     . emms-skip-backward)
         ("A"     . emms-browser-search-by-artist-at-point)
         ("r"     . emms-rate)
         ("c"     . emms-comment)
         ("R"     . emms-random)
         ("l"     . emms-love)))

(provide 'iw-emms)
;;; iw-emms.el ends here
