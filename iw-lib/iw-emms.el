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
  
  ;;(setq stats-db  (sqlite-open "~/.mpd/stats.db"))
  ;; TODO move this into emms?
  ;; (defun get-play-count (track)
  ;;   (sqlite-execute (sqlite-open "~/.mpd/stats.db")
  ;;                   (format "SELECT play_count FROM song WHERE uri=\"%s\""
  ;;                           (string-trim-left (emms-track-get track 'name)
  ;;                                             (concat (expand-file-name emms-player-mpd-music-directory) "/")))))

  ;; (defun get-current-track-play-count ()
  ;;   (interactive)
  ;;   (message (format "Play count %d" (first (first (get-play-count (emms-playlist-current-selected-track)))))))

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

  (global-set-key [f7] 'emms-seek-backward)
  (global-set-key [f9] 'emms-seek-forward)

  :bind (:map
         emms-browser-mode-map
         ("p"     . emms-playlist-mode-go)
         ("a"     . emms-browser-add-tracks)
         ("F"     . emms-show-all)
         ("d"     . emms-browser-view-in-dired)
         ("RET"   . emms-browser-toggle-subitems)
         ("<tab>" . emms-browser-next-non-track)
         ("C-s"   . swiper)
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
