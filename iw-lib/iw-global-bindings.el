;;; iw-global-bindings --- set up keybindings
;;; Commentary:
;;; Weird and naughty things that may upset someone used to the standard bindings.
;;; Mode specific bindings are in the setup file for that mode
;;; Code:

(global-set-key (kbd "M-~")        'switch-to-next-buffer)
(global-set-key (kbd "M-`")        'switch-to-prev-buffer)
(global-set-key (kbd "C-\\")       'align-regexp)
(global-set-key (kbd "M-SPC ")     'live-delete-whitespace-except-one)
(global-set-key (kbd "M-/")        'comment-or-uncomment-region)
(global-set-key (kbd "C-;")        'iw-eol-and-delete-whitespace-except-one)

;; This is not the default behavior, where C-x SPC selects rectangle-mark-mode
;; C-space is used by MacOS, so set C-x SPC to the more useful set-matk-command
(global-set-key (kbd "C-x TAB")    'rectangle-mark-mode)
(global-set-key (kbd "C-x SPC")    'set-mark-command)

;; For GUI Emacs, terminal version doesn't see C-TAB
(global-set-key (kbd "C-<tab>")    'other-window)

;; Who needs to suspend emacs from within? Much more useful to scroll text.
(global-set-key (kbd "C-z")        'scroll-down)

;; Also not default. C-a usually goes to the begining. Back to indentation is far more useful
(global-set-key (kbd "C-a")        'back-to-indentation)
(global-set-key (kbd "M-m")        'move-beginning-of-line)

;; Shortcuts for C-x-digit commands
(global-set-key (kbd "M-1")        'delete-other-windows)
(global-set-key (kbd "M-0")        'delete-window)
(global-set-key (kbd "M-o")        'other-window)
(global-set-key (kbd "M-2")        'split-window-below)
(global-set-key (kbd "M-3")        'split-window-right)

;; Tmux steals C-q so this will have to do instead.
(global-set-key (kbd "M-q")        'quoted-insert)

;; Using M-<up> etc doesn't work in setting a key, but ESC does and it amounts the same thing.
;; Pressing M-up still goes back a paragraph etc. howdoyou will steal this binding.
(global-set-key (kbd "ESC <down>") 'forward-paragraph)
(global-set-key (kbd "ESC <up>")   'backward-paragraph)

;; This is so that command-c etc can be remapped in the iterm settings
;; remapping M-something doesn't work.
(global-set-key (kbd "C-x c")      'kill-ring-save)
(global-set-key (kbd "C-x z")      'undo-tree-undo)

(provide 'iw-global-bindings)
;;; iw-global-bindings.el ends here
