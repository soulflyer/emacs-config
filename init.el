;;; Setup use-package before anything else:
;;; Easiest to do this by hand.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-install 'use-package)
(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'blackbored)
(add-to-list 'load-path "~/.emacs.d/lib")

(load "iw-cleanup")
(load "iw-single-window")
(load "iw-counsel")
(load "iw-popwin")
(load "iw-mac-osx")
(load "iw-expand-region")
(load "iw-projectile")
(load "iw-rainbow-delimiters")
(load "iw-flycheck.el")

(use-package which-key
  :config
  (which-key-mode t))
(use-package smartparens)
(use-package paradox)
