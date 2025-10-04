;;; iw-global-bindings --- set up keybindings
;;; Commentary:
;;; Weird and naughty things that may upset someone used to the standard bindings.
;;; Mode specific bindings are in the setup file for that mode
;;; Code:

(global-set-key (kbd "s-x")         'execute-extended-command)
(global-set-key (kbd "M-~")         'switch-to-next-buffer)
(global-set-key (kbd "M-`")         'switch-to-prev-buffer)
(global-set-key (kbd "M-\\")        'switch-to-prev-buffer)
(global-set-key (kbd "M-|")         'switch-to-next-buffer)
(global-set-key (kbd "C-\\")        'align-regexp)
(global-set-key (kbd "M-;")         'live-delete-whitespace-except-one)
(global-set-key (kbd "M-/")         'comment-dwim)
(global-set-key (kbd "C-;")         'iw-eol-and-delete-whitespace-except-one)

;; This is not the default behavior, where C-x SPC selects rectangle-mark-mode
;; C-space is used by MacOS, so set C-x SPC to the more useful set-mark-command
(global-set-key (kbd "C-x TAB")     'rectangle-mark-mode)
(global-set-key (kbd "C-x SPC")     'set-mark-command)


;; Who needs to suspend emacs from within? Much more useful to scroll text.
(global-set-key (kbd "C-z")         'scroll-down)

(global-set-key (kbd "C-a")         'smart-line-beginning)
(global-set-key (kbd "C-e")         'smart-line-end)

;; mostly to cleanup when gui emacsclient insists on adding the menu bar. Kinda handy anyway.
(global-set-key (kbd "M-m")         'menu-bar-mode)

(global-set-key (kbd "M-o")         'other-window)

;; Tmux steals C-q so this will have to do instead.
(global-set-key (kbd "M-q")         'quoted-insert)

;; Using M-<up> etc doesn't work in setting a key, but ESC does and it amounts the same thing.
;; Pressing M-up still goes back a paragraph etc. howdoyou will steal this binding.
;; (global-set-key (kbd "ESC <down>") 'forward-paragraph)
;; (global-set-key (kbd "ESC <up>")   'backward-paragraph)
;; moved to bind-keys* because org-mode was still stealing it.

;; This is so that command-c etc can be remapped in the iterm settings
;; remapping M-something doesn't work.
(global-set-key (kbd "C-x c")       'kill-ring-save)
(global-set-key (kbd "C-x z")       'undo-tree-undo)
(global-set-key (kbd "C-x ;")       'iw-eol-and-delete-whitespace-except-one)
                                    
(global-set-key (kbd "C-c b k")     'backward-kill-line)

(global-set-key (kbd "C-x 8 r")     "🟥")
(global-set-key (kbd "C-x 8 g")     "🟩")
(global-set-key (kbd "C-x 8 o")     "🟧")
(global-set-key (kbd "C-x 8 y")     "🟨")
(global-set-key (kbd "C-x 8 p")     "🟪")
(global-set-key (kbd "C-x 8 w")     "⬜")
(global-set-key (kbd "C-x 8 b")     "🟦")
(global-set-key (kbd "C-x 8 B")     "🟫")
(global-set-key (kbd "C-x 8 k")     "⬛")

(global-set-key (kbd "C-h x")       'howdoyou-query)
(global-set-key (kbd "C-h SPC")     'hyperspace)

(global-set-key (kbd "C-x w m")     'ace-swap-window)
(global-set-key (kbd "C-x w r")     'window-swap-states)
(global-set-key (kbd "C-x C-r")     'resize-window)

(defun start-new-eshell () "Whatever." (interactive) (eshell t))

(global-set-key (kbd "C-c e")       'start-new-eshell)
(global-set-key (kbd "C-c C-e")     'start-new-eshell)

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
(global-set-key (kbd "C-q d")       'tab-kill-and-close)
(global-set-key (kbd "C-q C-d")     'tab-kill-and-close)
(global-set-key (kbd "C-q z")       'zygospore-toggle-delete-other-windows)
(global-set-key (kbd "C-q x")       'delete-window)
(global-set-key (kbd "s-`")         'tab-next)
(global-set-key (kbd "s-~")         'tab-previous)
(global-set-key (kbd "C-q n")       'tab-next)
(global-set-key (kbd "C-q p")       'tab-previous)
(global-set-key (kbd "s-\\")        'tab-next)
(global-set-key (kbd "s-|")         'tab-previous)
(global-set-key (kbd "C-q TAB")     'tab-switch)

(defun tab-emacs          () "Whatever."(interactive) (tab-workspace-new "~/.emacs.d" "Emacs"))
(defun tab-photo-api      () "Whatever."(interactive) (tab-workspace-new "~/Code/Clojure/photo-api"))
(defun tab-hinh-anh       () "Whatever."(interactive) (tab-workspace-new "~/Code/Clojure/hinh-anh"))
(defun tab-image-lib      () "Whatever."(interactive) (tab-workspace-new "~/Code/Clojure/image-lib"))
(defun tab-drawinginsight () "Whatever."(interactive) (tab-workspace-new "~/Code/Immutablecollection/drawinginsight-d3" "DrawingInsight"))
(defun tab-profile        () "Whatever."(interactive) (tab-workspace-new "~/Code/profile"))
(defun tab-overtone       () "Whatever."(interactive) (tab-workspace-new "~/Code/Clojure/overtone"))

(global-set-key (kbd "C-q t h")   'tab-workspace-home)
(global-set-key (kbd "C-q h")     'tab-workspace-only-home)
(global-set-key (kbd "C-q t t")   'read-new-tab-name-and-create)
(global-set-key (kbd "C-q c")     'tab-calendar)
(global-set-key (kbd "C-q t e")   'tab-emacs)
(global-set-key (kbd "C-q t a")   'tab-photo-api)
(global-set-key (kbd "C-q t c a") 'tab-photo-api)
(global-set-key (kbd "C-q t c h") 'tab-hinh-anh)
(global-set-key (kbd "C-q t c i") 'tab-image-lib)
(global-set-key (kbd "C-q t c o") 'tab-overtone)
(global-set-key (kbd "C-q t d")   'tab-drawinginsight)
(global-set-key (kbd "C-q t i")   'tab-image-lib)
(global-set-key (kbd "C-q t m")   'tab-music)
(global-set-key (kbd "C-q t o")   'tab-overtone)
(global-set-key (kbd "C-q t p")   'tab-profile)

(global-set-key (kbd "C-c b")     'iw-open-bookshelf)
(global-set-key (kbd "C-c C-l")   'iw-open-library)
(global-set-key (kbd "C-c i")     'emms-browser)
(global-set-key (kbd "C-c C-i")   'emms)
(global-set-key (kbd "C-c C-m")   'emms-metaplaylist-mode-go)
(global-set-key [f8]              'emms-pause)

(global-unset-key (kbd "C-M-i"))
(keymap-unset cider-mode-map "C-M-i")

;; Muscle memory is causing me to occasionaly delete the region when trying to hit M-x
;; (global-unset-key (kbd "s-x"))

;; These are added to a minor mode map that is generally applied so that keybindings here
;; will over-ride ones made elsewhere like the heinous org-mode M-n that moves paragraphs!
;; A useful alternative is remap: see iw-org.el for an example
(bind-keys* ("M-<down>" . forward-paragraph)
            ("M-<up>"   . backward-paragraph)
            ;; For GUI Emacs, terminal version doesn't see C-TAB
            ("C-<tab>"   . other-window)
            ("C-S-<tab>" . previous-window-any-frame)
            ("C-c d e"  . zetteldeft-extract-region-to-note)
            ("C-c d 2"  . zetteldeft-tag-insert)
            ("C-c d 3"  . zetteldeft-tag-insert)
            ("C-c d r"  . deft-refresh)
            ("C-c d R"  . zetteldeft-file-rename)
            ("C-c d z"  . iw-nv-zd)
            ("C-c C-j"  . avy-goto-char-in-line)
            ("C-c j"    . ace-jump-word-mode)
            ("C-j"      . avy-goto-char-timer))


;; (global-set-key (kbd "C-<tab>")  'other-window)
(keymap-unset org-agenda-mode-map "S")
(keymap-set org-agenda-mode-map "S" 'iw-save-org-files)

(provide 'iw-global-bindings)
;;; iw-global-bindings.el ends here
