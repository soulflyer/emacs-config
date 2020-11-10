;;; iw-rainbow-mode --- Setup rainbow mode
;;; Commentary: This colours the background of colour specs, hex and string "red" #0000ff

;;; Code:
(use-package rainbow-mode
  :ensure t
  :config
  (setq rainbow-html-colors t
	rainbow-r-colors t)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
  :delight)
(provide 'iw-rainbow-mode)
;;; iw-rainbow-mode.el ends here
