;;; iw-arduino.el --- Arduino mode setup             -*- lexical-binding: t; -*-
;; Copyright (C) 2025  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(setq-default arduino-mode-home "~/Code/Arduino")

(use-package arduino-mode
  :ensure t)

(use-package arduino-cli-mode
  :ensure t
  :hook arduino-mode
  :mode "\\.ino\\'"
  :custom
  (arduino-cli-warnings 'all)
  (arduino-cli-verify t)
  :config
  (arduino-cli-mode 1))

(provide 'iw-arduino)
;;; iw-arduino.el ends here
