;;; iw-markdown.el ---                               -*- lexical-binding: t; -*-
;; Copyright (C) 2023  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(use-package impatient-showdown
  :ensure t
  :config
  (setq impatient-showdown-markdown-background-color "#ddccaa")
  :bind (:map markdown-mode-map
              ("C-c m s" . impatient-showdown-mode)))

(provide 'iw-markdown)
;;; iw-markdown.el ends here
