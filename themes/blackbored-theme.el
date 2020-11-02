;;; blackbored-theme --- pretty colours
;;; Commentary:
;;; Code:
(deftheme blackbored)
(custom-theme-set-faces
 'blackbored
 '(default                             ((t (:background "Black" :foreground "white"))))
 '(mode-line                           ((t (:background "gray20" :foreground "#20d030"))))
 '(mode-line-inactive                  ((t (:background "gray10" :foreground "gray30"))))
 '(hl-line                             ((t (:background "#101010"))))
 '(diary                               ((t (:foreground "orange"))))
 '(font-lock-builtin-face              ((t (:foreground "#4c83ff"))))
 '(font-lock-comment-face              ((t (:foreground "#8a8a8a"))))
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

 '(popup-face                          ((t (:background "#303030" :foreground "yellow"))))
 '(popup-tip-face                      ((t (:background "#303030" :foreground "#20d020"))))

 '(rainbow-delimiters-depth-1-face     ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face     ((t (:foreground "dark green"))))
 '(rainbow-delimiters-depth-3-face     ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-4-face     ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-5-face     ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-6-face     ((t (:foreground "light blue"))))
 '(rainbow-delimiters-depth-7-face     ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-8-face     ((t (:foreground "slate blue"))))
 '(rainbow-delimiters-depth-9-face     ((t (:foreground "light gray"))))
 '(rainbow-delimiters-unmatched-face   ((t (:foreground "white"))))
 )

(provide-theme 'blackbored)
;;; blackbored-theme.el ends here
