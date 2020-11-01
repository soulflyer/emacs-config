;;; iw-mac-osx.el --- osx specific setup
;;; Commentary:
;;; Mostly taken from Sam Aarons emacs-live

(require 'use-package)
;;; Code:

(setq default-input-method "MacOSX")

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(provide 'iw-mac-osx)
;;; iw-mac-osx.el ends here
