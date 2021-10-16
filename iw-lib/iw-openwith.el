;;; iw-openwith.el --- setup openwith                -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>

;;; Commentary:

;;
(require 'use-package)
;;; Code:

(use-package openwith
  :ensure t
  :init
  (setq openwith-associations '(("\\.\\(png\\|jp?g\\|pdf\\)\\'" "open" (file))
                                ("\\.torrent\\'" "open" (file))
                                ("\\.\\(mp3\\|avi\\|wmv\\)\\'" "vlc" (file))
                                ("\\.\\(doc\\|odt\\|xls\\|ods\\|ppt\\|odp\\)\\'" "open" (file))))
  :config
  (openwith-mode t))

(provide 'iw-openwith)
;;; iw-openwith.el ends here
