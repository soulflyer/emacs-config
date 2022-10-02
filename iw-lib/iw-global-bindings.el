;;; iw-global-bindings --- set up keybindings
;;; Commentary:
;;; Weird and naughty things that may upset someone used to the standard bindings.
;;; Mode specific bindings are in the setup file for that mode
;;; Code:

(global-set-key (kbd "M-~")        'switch-to-next-buffer)
(global-set-key (kbd "M-`")        'switch-to-prev-buffer)
(global-set-key (kbd "C-\\")       'align-regexp)
(global-set-key (kbd "M-;")        'live-delete-whitespace-except-one)
(global-set-key (kbd "M-/")        'comment-dwim)
(global-set-key (kbd "C-;")        'iw-eol-and-delete-whitespace-except-one)

;; This is not the default behavior, where C-x SPC selects rectangle-mark-mode
;; C-space is used by MacOS, so set C-x SPC to the more useful set-mark-command
(global-set-key (kbd "C-x TAB")    'rectangle-mark-mode)
(global-set-key (kbd "C-x SPC")    'set-mark-command)

;; For GUI Emacs, terminal version doesn't see C-TAB
(global-set-key (kbd "C-<tab>")    'other-window)

;; Who needs to suspend emacs from within? Much more useful to scroll text.
(global-set-key (kbd "C-z")        'scroll-down)

(global-set-key (kbd "C-a")        'smart-line-beginning)
(global-set-key (kbd "C-e")        'smart-line-end)

;; mostly to cleanup when gui emacsclient insists on adding the menu bar. Kinda handy anyway.
(global-set-key (kbd "M-m")        'menu-bar-mode)

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
;; (global-set-key (kbd "ESC <down>") 'forward-paragraph)
;; (global-set-key (kbd "ESC <up>")   'backward-paragraph)
;; moved to bind-keys* because org-mode was still stealing it.

;; This is so that command-c etc can be remapped in the iterm settings
;; remapping M-something doesn't work.
(global-set-key (kbd "C-x c")      'kill-ring-save)
(global-set-key (kbd "C-x z")      'undo-tree-undo)
(global-set-key (kbd "C-x ;")      'iw-eol-and-delete-whitespace-except-one)

(global-set-key (kbd "C-c b k")    'backward-kill-line)

(global-set-key (kbd "C-x 8 r")    "🟥")
(global-set-key (kbd "C-x 8 g")    "🟩")
(global-set-key (kbd "C-x 8 o")    "🟧")
(global-set-key (kbd "C-x 8 y")    "🟨")
(global-set-key (kbd "C-x 8 p")    "🟪")
(global-set-key (kbd "C-x 8 w")    "⬜")
(global-set-key (kbd "C-x 8 b")    "🟦")
(global-set-key (kbd "C-x 8 B")    "🟫")
(global-set-key (kbd "C-x 8 k")    "⬛")

(global-set-key (kbd "C-h x") 'howdoyou-query)

(global-set-key (kbd "C-x w m") 'ace-swap-window)
(global-set-key (kbd "C-x w r") 'window-swap-states)
(global-set-key (kbd "C-x C-r") 'resize-window)

(global-set-key (kbd "C-c b l") 'bookmark-bmenu-list)
(global-set-key (kbd "C-c b n") 'burly-bookmark-windows)

;; these keys are never seen in terminal emacs as tmux grabs C-q
;; Only rebinding them to avoid muscle memory problems switching to GUI Emacs
;; There are problems with vterm though....
(global-unset-key (kbd "C-q"))
(global-set-key (kbd "C-q C-q")     'other-window)
(global-set-key (kbd "C-q SPC")     'window-swap-states)
(global-set-key (kbd "C-q RET")     'ace-swap-window)
(global-set-key (kbd "C-q <up>")    'resize-window)
(global-set-key (kbd "C-q <down>")  'resize-window)
(global-set-key (kbd "C-q <left>")  'resize-window)
(global-set-key (kbd "C-q <right>") 'resize-window)
(global-set-key (kbd "C-q f")       'iw-set-font-size)
(global-set-key (kbd "s-`")         'tab-next)

;; These are added to a minor mode map that is generally applied so that keybindings here
;; will over-ride ones made elsewhere like the heinous org-mode M-n that moves paragraphs!
;; A useful alternative is remap: see iw-org.el for an example
(bind-keys* ("M-n"        . forward-paragraph)
            ("M-p"        . backward-paragraph)
            ;; FIXME the above work, but the following don't
            ("ESC <down>" . forward-paragraph)
            ("ESC <up>"   . backward-paragraph)

            ("C-c C-b"    . (lambda () (interactive) (find-file "~/Documents/books/bookshelf/")))
            ("C-c d e"    . zetteldeft-extract-region-to-note)
            ("C-c d 2"    . zetteldeft-tag-insert)
            ("C-c d 3"    . zetteldeft-tag-insert)
            ("C-c d r"    . deft-refresh)
            ("C-c d R"    . zetteldeft-file-rename)
            ("C-c d z"    . iw-nv-zd)
            ("C-c C-j"    . avy-goto-char-in-line)
            ("C-c j"      . avy-goto-char-timer))

(provide 'iw-global-bindings)
;;; iw-global-bindings.el ends here
