;;; iw-cleanup --- tidy up the display
;;; Commentary:
;;; Code:
(require 'use-package)

;;; get rid of clutter
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; remove bells
(setq ring-bell-function 'ignore)

;;; make fringe smaller
(if (fboundp 'fringe-mode)
    (fringe-mode 4))

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'cider-repl-mode))

(setq-default truncate-lines t)
(provide 'iw-cleanup)
;;; iw-cleanup.el ends here
