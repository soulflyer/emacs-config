;;; iw-transcendence.el --- COnfig specific to Transcendence  -*- lexical-binding: t; -*-
;; Copyright (C) 2025  iain
;; Author: iain <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

;; (setq org-attach-screenshot-command-line "gnome-screenshot -a --file %f")
(setq org-attach-screenshot-command-line "spectacle -o %f"
      lsp-clojure-server-command '("/usr/local/bin/clojure-lsp")
      org-ditaa-jar-path "/usr/bin/ditaa"
      org-file-apps                      '((auto-mode . emacs)
                                           (directory . emacs)
                                           ("\\.mm\\'" . default)
                                           ("\\.x?html?\\'" . default)
                                           ("\\.pdf::\\([0-9]+\\)\\'" . "evince -p %1 %s")
                                           ("\\.pdf\\'" . "evince %s")
                                           ("\\.vcv\\'" . "~/bin/vcv-rack %s")))

(provide 'iw-transcendence)
;;; iw-transcendence.el ends here
