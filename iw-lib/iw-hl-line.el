;;; iw-hl-line --- highlight line
;;; Commentary:
;;; method 1:
;;; set the highlight line to dissapear when its active so that coloured hex vals don't flash
;;; Method 2:
;;; Only highlight the line after the last character. Taken from https://emacs.stackexchange.com/a/10446/2666

;;; Code:
;;; Method 1
;; (require 'hl-line+)
;; (setq global-hl-line-mode nil)
;; (toggle-hl-line-when-idle t)
;; (hl-line-when-idle-interval 0.3)

;;; Method 2
(defun my-hl-line-range-function ()
  "Specify the range to be highlighted."
  (cons (line-end-position) (line-beginning-position 2)))
(setq hl-line-range-function #'my-hl-line-range-function)
(global-hl-line-mode 1)

(setq global-hl-line-sticky-flag nil)

(provide 'iw-hl-line)
;;; iw-hl-line.el ends here
