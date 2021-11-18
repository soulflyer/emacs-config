;;; init.el --- all starts here
;;; Commentary:
;;; Code:
;; Set some paths.
(add-to-list 'package-archives       '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path              "~/.emacs.d/lib")
(add-to-list 'load-path              "~/.emacs.d/iw-lib")
(setq custom-file                    "~/.emacs.d/etc/emacs-custom.el")
(setq-default diary-file             "~/Documents/org-mode/diary"
              bm-repository-file     "~/.emacs.d/etc/bm-repository"
              org-agenda-files       '("~/Documents/org-mode/agenda" "~/Documents/org-mode/notes")
              world-clock-list       t
              zoneinfo-style-world-list '(("Asia/Saigon" "Vietnam")
                                          ("Europe/Kiev" "Ukraine")
                                          ("Europe/London" "Newcastle")
                                          ("Europe/Prague" "Czech")
                                          ("Europe/Budapest" "Hungary")
                                          ("Argentina/Buenos_Aires" "Argentina")
                                          ("America/Montevideo" "Uraguay"))
              world-clock-time-format    "%a %d %b %R %Z")

(load custom-file)
(load-theme  'blackbored)

;; This setup makes extensive use of package and use-package.  Install them first.
(require 'iw-package)

;; Add config for specific systems and machines.
(when (eq system-type 'darwin)
  (require 'iw-mac-osx))
(when (string= "subversion\n" (shell-command-to-string "hostname -s"))
  (require 'iw-subversion))
(when (string= "acceptance\n" (shell-command-to-string "hostname -s"))
  (require 'iw-acceptance))

(if (display-graphic-p)
    (require 'iw-gui-emacs)
  (require 'iw-terminal-emacs))

;;  Add config for specific purposes.
;; (require 'iw-bookmark)
(require 'iw-cleanup)
(require 'iw-clojure)
(require 'iw-external)
(require 'iw-git)
(require 'iw-jump)
(require 'iw-lsp)
(require 'iw-music)
(require 'iw-occur)
(require 'iw-org)
(require 'iw-regex)
(require 'iw-reify)
(require 'iw-single-window)
(require 'iw-text)
(require 'iw-term)
(require 'iw-tweaks)

;;Most of these are just a single package.
(require 'iw-auto-complete)
(require 'iw-autocompile)
(require 'iw-auto-insert)
(require 'iw-browse-kill-ring)
(require 'iw-counsel)
(require 'iw-dash)
(require 'iw-dashboard)
(require 'iw-deft)
(require 'iw-dired)
(require 'iw-expand-region)
(require 'iw-flycheck)
;;(require 'iw-forth)
(require 'iw-hl-line)
(require 'iw-ibuffer)
(require 'iw-lisp)
(require 'iw-javascript)
(require 'iw-mouse)
(require 'iw-multiple-cursors)
;; ;; popwin messes up edwina display, so maybe only use this when not in GUI Emacs
;; (require 'iw-popwin)
(require 'iw-projectile)
(require 'iw-rainbow-delimiters)
(require 'iw-rainbow-mode)
;; paredit or smartparens, not both. They use the same bindings.
;; (require 'iw-paredit)
(require 'iw-smartparens)
(require 'iw-spell)
(require 'iw-undo-tree)
(require 'iw-visible-mark)
(require 'iw-which-key)
(require 'iw-yasnippet)

;; Add the extra bindings last so they don't get overwriiten.
(require 'iw-global-bindings)

;; TODO move these to somewhere else
(defun slurp (f)
  (with-temp-buffer
    (insert-file-contents f)
    (buffer-substring-no-properties
     (point-min)
     (point-max))))

(message (concat "\n\n" (slurp (concat user-emacs-directory "banners/banner.txt")) "\n\n"))

;;; init.el ends here
