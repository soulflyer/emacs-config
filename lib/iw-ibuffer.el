;;; iw-ibuffer --- tidy up ibuffer display
;;; Commentary:
;;; Code:
(setq ibuffer-formats '((mark modified read-only " "
                              (size 7 -1 :left :elide)
                              (name))
                        (mark filename)))
(provide 'iw-ibuffer)
;;; iw-ibuffer.el ends here
