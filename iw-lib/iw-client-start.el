;;; iw-client-start.el ---                           -*- lexical-binding: t; -*-
;; Copyright (C) 2023  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(defun iw-server-after-make-frame ()
  (message "************************* Starting a client *************************")
  (if (display-graphic-p)
      (require 'iw-gui-emacs)
    (message "************************* We are starting a terminal instance ************************************")))

(add-hook 'server-after-make-frame-hook 'iw-server-after-make-frame)

(provide 'iw-client-start)
;;; iw-client-start.el ends here
