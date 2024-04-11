;;; iw-folding.el ---                                -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(defun iw-adjust-block-beginning (_initial)
  (save-excursion
    (forward-line)
    (point)))

(global-set-key (kbd "C-c f f") 'hs-hide-block)
(global-set-key (kbd "C-c f u") 'hs-show-block)
(global-set-key (kbd "C-c f a") 'hs-show-all)
(global-set-key (kbd "C-c f h") 'hs-hide-all)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(provide 'iw-folding)
;;; iw-folding.el ends here
