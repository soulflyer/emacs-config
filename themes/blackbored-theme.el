;;; blackbored-theme --- pretty colours
;;; Commentary:
;;; Code:
(deftheme blackbored)
(custom-theme-set-faces
 'blackbored
 '(default                             ((t (:background "Black" :foreground "white"))))
 '(mode-line                           ((t (:background "gray10" :foreground "#4cff83"))))
 '(hl-line                             ((t (:background "#101010"))))
 '(font-lock-builtin-face              ((t (:foreground "#4c83ff"))))
 '(font-lock-comment-face              ((t (:foreground "#8a8aaa"))))
 '(font-lock-constant-face             ((t (:foreground "#D8FA3C"))))
 '(font-lock-doc-string-face           ((t (:foreground "Darkorange"))))
 '(font-lock-function-name-face        ((t (:foreground "magenta"))))
 '(font-lock-keyword-face              ((t (:foreground "#FBDE2D"))))
 '(font-lock-preprocessor-face         ((t (:foreground "gray57"))))
 '(font-lock-reference-face            ((t (:foreground "gray"))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#E9C062"))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "red"))))
 '(font-lock-string-face               ((t (:foreground "#61CE3C"))))
 '(font-lock-type-face                 ((t (:foreground "#E00000"))))
 '(font-lock-variable-name-face        ((t (:foreground "#FF6400"))))
 '(font-lock-warning-face              ((t (:foreground "Pink"))))
 '(font-lock-doc-face                  ((t (:background "Black" :foreground "#61CE3C"))))
 '(region                              ((t (:background "#7F073F"))))
 )

(provide-theme 'blackbored)
;;; blackbored-theme.el ends here
