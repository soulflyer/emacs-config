;;; iw-mew.el ---                                    -*- lexical-binding: t; -*-
;; Copyright (C) 2023  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;; HTML support
(setq mew-mime-multipart-alternative-list '("Text/Html" "Text/Plain" "*."))
(condition-case nil
    (require 'mew-w3m)
  (file-error nil))
(setq mew-use-text/html t)

(provide 'iw-mew)
;;; iw-mew.el ends here
