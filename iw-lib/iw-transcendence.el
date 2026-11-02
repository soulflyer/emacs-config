;;; iw-transcendence.el --- COnfig specific to Transcendence  -*- lexical-binding: t; -*-
;; Copyright (C) 2025  iain
;; Author: iain <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

;; (setq org-attach-screenshot-command-line "gnome-screenshot -a --file %f")
(setq org-attach-screenshot-command-line "spectacle -o %f"
      lsp-clojure-server-command '("/usr/local/bin/clojure-lsp")
      org-ditaa-jar-path "/usr/bin/ditaa")
(provide 'iw-transcendence)
;;; iw-transcendence.el ends here
