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
;; (setq use-package-always-ensure t)

(require 'org-loaddefs)

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'blackbored)
(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d/iw-lib")

(setq savehist-autosave-interval 30
      savehist-mode t)

(require 'iw-cleanup)
(require 'iw-counsel)
(require 'iw-dired)
(require 'iw-expand-region)
(require 'iw-flycheck)
(require 'iw-hl-line)
(require 'iw-ibuffer)
(require 'iw-mac-osx)
(require 'iw-popwin)
(require 'iw-projectile)
(require 'iw-rainbow-delimiters)
(require 'iw-single-window)
(require 'iw-smartparens)
(require 'iw-global-bindings)

(use-package which-key
  :config
  (which-key-mode t))

(use-package paradox
  :ensure t
  :config (paradox-enable))

(use-package rainbow-mode
  :ensure t
  :config
  (setq rainbow-html-colors t
	rainbow-r-colors t)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-mode))

;;; init.el ends here
