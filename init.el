;;; init.el --- all starts here
;;; Commentary:
;;; Setup use-package before anything else:
;;; May need to do the first part by hand after a fresh install.

;;; Code:
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(package-install 'use-package)
(require 'use-package)
(require 'use-package-ensure)

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'blackbored)
(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d/iw-lib")

(setq-default savehist-autosave-interval 30)
(setq savehist-mode t)

;;; This allows us to use space to accept y/n questions.
(defalias 'yes-or-no-p 'y-or-n-p)

(require 'iw-autocompile)
(require 'iw-browse-kill-ring)
(require 'iw-cleanup)
(require 'iw-counsel)
(require 'iw-dired)
(require 'iw-expand-region)
(require 'iw-flycheck)
(require 'iw-git)
(require 'iw-hl-line)
(require 'iw-ibuffer)
(require 'iw-lisp)
(require 'iw-mac-osx)
(require 'iw-mouse)
(require 'iw-popwin)
(require 'iw-projectile)
(require 'iw-rainbow-delimiters)
(require 'iw-rainbow-mode)
(require 'iw-single-window)
(require 'iw-smartparens)
(require 'iw-text)
(require 'iw-global-bindings)

(use-package which-key
  :config
  (which-key-mode t))

(use-package paradox
  :ensure t
  :config (paradox-enable))



;;; init.el ends here
