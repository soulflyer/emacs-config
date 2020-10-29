;;; iw-global-bindings --- set up keybindings
;;; Commentary:
;;; Mode specific bindings are in the setup file for that mode
;;; Code:

(global-set-key (kbd "M-~")     'switch-to-next-buffer)
(global-set-key (kbd "M-`")     'switch-to-prev-buffer)
(global-set-key (kbd "C-x b")   'ibuffer)
;;(global-set-key (kbd "C-x SPC") 'rectangle-mark-mode)
(global-set-key (kbd "C-x TAB") 'set-mark-command)

(provide 'iw-global-bindings)
;;; iw-global-bindings.el ends here
