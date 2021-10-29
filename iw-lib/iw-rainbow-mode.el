;;; iw-rainbow-mode --- Setup rainbow mode
;;; Commentary:
;; This colours the background of colour specs, hex and string "red" #0000ff
;; TODO make this only colour #nnnnnn not colour names

;;; Code:
(use-package rainbow-mode
  :ensure t
  :config
  (setq rainbow-html-colors nil
	rainbow-r-colors nil)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
  :delight)
(provide 'iw-rainbow-mode)
;;; iw-rainbow-mode.el ends here
