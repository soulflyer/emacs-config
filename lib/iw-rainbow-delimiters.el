;;; iw-rainbow-delimiters --- setup pretty parens
;;; Commentary:

;;; Code:
(require 'use-package)
(use-package rainbow-delimiters
  :custom-face
  (rainbow-delimiters-depth-1-face   ((t (:foreground "dark red"))))
  (rainbow-delimiters-depth-2-face   ((t (:foreground "dark green"))))
  (rainbow-delimiters-depth-3-face   ((t (:foreground "deep pink"))))
  (rainbow-delimiters-depth-4-face   ((t (:foreground "yellow"))))
  (rainbow-delimiters-depth-5-face   ((t (:foreground "green"))))
  (rainbow-delimiters-depth-6-face   ((t (:foreground "light blue"))))
  (rainbow-delimiters-depth-7-face   ((t (:foreground "orange"))))
  (rainbow-delimiters-depth-8-face   ((t (:foreground "slate blue"))))
  (rainbow-delimiters-depth-9-face   ((t (:foreground "light gray"))))
  (rainbow-delimiters-unmatched-face ((t (:foreground "white"))))
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(provide 'iw-rainbow-delimiters)
;;; iw-rainbow-delimiters.el ends here
