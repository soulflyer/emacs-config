;;; init.el --- all starts here
;;; Commentary:
;;; Setup use-package before anything else:
;;; May need to do the first part by hand after a fresh install.

;;; Code:
;; This setup makes extensive use of package and use-package.  Install them first.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(when (not (package-installed-p 'use-package))
  (package-install 'use-package))
(require 'use-package)
(require 'use-package-ensure)
(use-package delight
  :ensure t)
(use-package paradox
  :ensure t
  :init (paradox-enable))

;; Set some paths.
(setq custom-file                    "~/.emacs.d/etc/emacs-custom.el")
(load custom-file)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path              "~/.emacs.d/lib")
(add-to-list 'load-path              "~/.emacs.d/iw-lib")
(setq diary-file                     "~/Documents/org-mode/diary"
      bm-repository-file     "~/.emacs.d/etc/bm-repository"
      org-agenda-files       '("~/Documents/org-mode/agenda"))

(load-theme  'blackbored)

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
(require 'iw-bookmark)
(require 'iw-cleanup)
(require 'iw-clojure)
(require 'iw-external)
(require 'iw-git)
(require 'iw-jump)
(require 'iw-lsp)
(require 'iw-music)
(require 'iw-org)
(require 'iw-reify)
(require 'iw-single-window)
(require 'iw-text)
(require 'iw-term)
(require 'iw-tweaks)

;;Most of these are just a single package.
(require 'iw-auto-complete)
(require 'iw-autocompile)
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
(require 'iw-undo-tree)
(require 'iw-visible-mark)
(require 'iw-which-key)
(require 'iw-yasnippet)

;; Add the extra bindings last so they don't get overwriiten.
(require 'iw-global-bindings)

;; Display a message, useful when starting the server.
(setq ascii-art-running
      ";;     MM\"\"\"\"\"\"\"\"`M
;;     MM  mmmmmmmM
;;     M`      MMMM 88d8b.d8b. .d8888b. .d8888b. .d8888b.
;;     MM  MMMMMMMM 88''88'`88 88'  `88 88'  `\"\" Y8ooooo.
;;     MM  MMMMMMMM 88  88  88 88.  .88 88.  ...       88
;;     MM        .M dP  dP  dP `88888P8 '88888P' '88888P'
;;     MMMMMMMMMMMM
;;
;;        M\"\"MMP\"\"\"\"\"\"`MM
;;        M  M M  mmmmm..M
;;        M  M M.      `YM
;;        M  M MMMMMMM.  M
;;        M  M M. .MMM'  M
;;        M  M Mb.     .dM
;;        MMMM MMMMMMMMMMM
;;
;;           M\"\"MMMMMMMM M\"\"M M\"\"MMMMM\"\"M MM\"\"\"\"\"\"\"\"`M
;;           M  MMMMMMMM M  M M  MMMMM  M MM  mmmmmmmM
;;           M  MMMMMMMM M  M M  MMMMP  M M`      MMMM
;;           M  MMMMMMMM M  M M  MMMM' .M MM  MMMMMMMM
;;           M  MMMMMMMM M  M M  MMP' .MM MM  MMMMMMMM
;;           M         M M  M M     .dMMM MM        .M
;;           MMMMMMMMMMM MMMM MMMMMMMMMMM MMMMMMMMMMMM")

(message (concat "\n\n" ascii-art-running "\n\n"))
;;; init.el ends here
