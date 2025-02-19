;;; iw-org.el --- setup org                          -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@subversion.local>
;;; Commentary:

;;; Code:
(require 'use-package)
(require 'iw-lisp)

(use-package org
  :init
  (setq-default org-agenda-window-setup 'current-window
                org-priority-faces (quote ((?A :foreground "#e000a0")
                                           (?B :foreground "#e00000")
                                           (?C :foreground "#f04000")
                                           (?D :foreground "#c0c000")
                                           (?E :foreground "#00d000")
                                           (?F :foreground "#00c0e0")
                                           (?G :foreground "#0060e0")
                                           (?H :foreground "#8060a0")
                                           (?I :foreground "#575757")))
                org-use-speed-commands t
                org-lowest-priority 73
                org-habit-graph-column 40
                org-habit-show-all-today t
                org-habit-preceding-days 15
                org-habit-following-days 15
                org-image-actual-width (list 240)
                org-startup-indented t
                org-startup-with-inline-images t)
  ;; (add-to-list 'display-buffer-alist
  ;;              '("*Agenda Commands*" display-buffer-in-direction
  ;;                (side . bottom)
  ;;                (inhibit-same-window . nil)))
  :config
  (font-lock-add-keywords
   'org-mode
   '(("\\(┃\\|┏.*┓\\|┣.*┫\\|┗.*┛\\|║\\|╔.*╗\\|╠.*╣\\|╚.*╝\\)" 1
      'font-lock-comment-face prepend)))

  ;; Stop org-capture from taking over the whole frame:
  ;; taken from https://stackoverflow.com/a/54251825/1671119
  (defun my-fn-dont-delete-windows (oldfun &rest args)
    "redefine `delete-other-windows' before calling OLDFUN which is passed in
by a call to `advice-add'"
    (cl-letf (((symbol-function 'delete-other-windows) 'ignore))
      (apply oldfun args)))

  (with-eval-after-load "org-capture"
    (advice-add 'org-capture-place-template :around 'my-fn-dont-delete-windows))

  (with-eval-after-load "org-agenda"
    (advice-add 'org-agenda-get-restriction-and-command :around 'my-fn-dont-delete-windows))

  (defun iw-zetteldeft-return ()
    "Calls zettledeft-search-at-point if in a tag, and zettledeft-follow-link
if in a link, otherwise it calls org-return
TODO a cond in an if in a cond ?!? Yuk
FIXME does nothing if at the end of a colapsed heading"
    (interactive)
    (let ((in-thing (cond ((thing-at-point 'symbol)
                           (if ; at the end of a symbol
                               (= (point) (cdr (bounds-of-thing-at-point 'symbol)))
                               nil
                             (save-excursion
                               (beginning-of-thing 'symbol)
                               (cond
                                ((and (not (string= "+" (thing-at-point 'char 'no-properties)))
                                      (= (char-before) 35)) ; preceeded by #
                                 "tag")
                                ((= (char-before) 167) ; preceeded by §
                                 "link")
                                (t                      nil)))))
                          ((string= "§" (thing-at-point 'char)) ; just before a §
                           "link")
                          ((string= "#" (thing-at-point 'char)) ; just before a #
                           "tag"))))
      (cond ((string= in-thing "tag") (zetteldeft-search-at-point))
            ((string= in-thing "link") (zetteldeft-follow-link))
            (t (org-return)))))

  (setq org-speed-commands-user nil)
  (add-to-list 'org-speed-commands-user '("4" org-priority 68))
  (add-to-list 'org-speed-commands-user '("5" org-priority 69))
  (add-to-list 'org-speed-commands-user '("6" org-priority 70))
  (add-to-list 'org-speed-commands-user '("7" org-priority 71))
  (add-to-list 'org-speed-commands-user '("8" org-priority 72))
  (add-to-list 'org-speed-commands-user '("9" org-priority 73))
  (setq-default org-return-follows-link t
                org-refile-targets          '((org-agenda-files :tag . ""))
                org-refile-use-outline-path 'file
                org-log-done                'time
                org-default-notes-file      "~/Documents/org-mode/notes/new-notes"
                org-taxonomy-file           "~/Documents/org-mode/plans/taxonomy.org"
                org-capture-templates       '(("e"
                                               "Emacs"
                                               plain
                                               (file+headline "~/Documents/org-mode/notes/emacs.org" "Emacs TODOs")
                                               "** TODO [#G] %?")
                                              ("f"
                                               "FIXME"
                                               plain
                                               (file+headline "~/Documents/org-mode/notes/fixme.org" "FIXME TODOs")
                                               "** TODO [#C] %?")
                                              ("s"
                                               "Sing use: <artist>:<title>"
                                               plain
                                               (file "~/Documents/org-mode/agenda/sing.org")
                                               "* %?: ")
                                              ("p"
                                               "Plan"
                                               plain
                                               (file "~/Documents/org-mode/plans/plan.org")
                                               "** TODO [#H] %?")
                                              ("S"
                                               "Study"
                                               plain
                                               (file+headline "~/Documents/org-mode/notes/study.org" "Things to study")
                                               "** TODO [#I] %?")
                                              ("t" "Taxonomy")
                                              ("tf" "Fish" entry (file+headline org-taxonomy-file "Fish")
                                               "*** %?%i")
                                              ("tc" "Crustacea" entry (file+headline org-taxonomy-file "Crustacea")
                                               "*** %?%i")
                                              ("ta" "Anemones" entry (file+headline org-taxonomy-file "Anemones")
                                               "* %?%i")
                                              ("tm" "Molluscs" entry (file+headline org-taxonomy-file "Molluscs")
                                               "* %?%i")
                                              ("ts" "Starfish" entry (file+headline org-taxonomy-file "Starfish")
                                               "* %?%i"))
                org-agenda-custom-commands   '(("n" "Agenda and all TODOs"
                                                ((agenda "" nil)
                                                 (alltodo "" nil))
                                                nil)
                                               ("c" "Capture" org-capture "" nil))
                org-confirm-babel-evaluate   nil
                org-babel-clojure-backend    'cider
                org-link-frame-setup         '((vm . vm-visit-folder)
                                               (vm-imap . vm-visit-imap-folder-other-frame)
                                               (gnus . org-gnus-no-new-news)
                                               (file . find-file)
                                               (wl . wl))
                org-src-window-setup         'plain
                org-hide-emphasis-markers    t
                org-hide-leading-stars       t
                org-file-apps                '((auto-mode . emacs)
                                               (directory . emacs)
                                               ("\\.mm\\'" . default)
                                               ("\\.x?html?\\'" . default)
                                               ("\\.pdf\\'" . emacs)))
  

  (autoload 'LilyPond-mode "lilypond-mode" "LilyPond Editing Mode" t)
  (add-to-list 'auto-mode-alist '("\\.ly\\'" . LilyPond-mode))
  (add-to-list 'auto-mode-alist '("\\.ily\\'" . LilyPond-mode))
  (add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))
  
  ;; removed this line from custom-set-variables in emacs-custom.el
  ;; '(org-babel-load-languages '((clojure . t) (ditaa . t) (emacs-lisp . t)))
  (org-babel-do-load-languages 'org-babel-load-languages '((clojure    . t)
                                                           (ditaa      . t)
                                                           (emacs-lisp . t)
                                                           (python     . t)
                                                           (shell      . t)
                                                           (J          . t)
                                                           (lilypond   . t)
                                                           (verb       . t)))
  
  (define-key org-mode-map [remap org-meta-return] 'live-lisp-describe-thing-at-point)

  (defun iw-lyrics-and-play ()
    (interactive)
    (iw-lyrics)
    (iw-emms-play-track))
  :bind (("C-c o" . org-agenda)
         :map org-mode-map
         ("C-c i"   . org-insert-structure-template)
         ("C-c C-o" . org-agenda-open-link)
         ("RET"     . iw-zetteldeft-return)
         ("C-c SPC SPC" . iw-lyrics)
         ("C-c SPC RET" . iw-emms-play-track)
         ("C-c l"   . iw-lyrics)
         ([f6]      . iw-lyrics-and-play)))

(use-package org-superstar
  :ensure t
  :config
  (org-superstar-mode)
  (setq org-superstar-cycle-headline-bullets nil
        org-superstar-headline-bullets-list '(129001 9724 9642))
  (add-hook 'org-mode-hook 'org-superstar-mode))

(add-hook 'calendar-initial-window-hook 'diary-mark-entries)

;; TODO I think this should be in :config with a mention of 'calendar in :commands.
(global-set-key (kbd "C-c c") 'calendar)

(defun iw-calendar-mode-hook ()
  "Whatever."
  (define-key calendar-mode-map (kbd "q") 'tab-calendar-exit))

(defun iw-dirfunction ()
  "Whatever."
  (cl-assert (buffer-file-name))
  (concat (file-name-sans-extension (buffer-file-name)) "-images"))

(use-package org-attach-screenshot
  :ensure t
  :config (setq org-attach-screenshot-command-line "screencapture -i %f"
                org-attach-screenshot-dirfunction 'iw-dirfunction))

(add-hook 'calendar-mode-hook 'iw-calendar-mode-hook)

(use-package verb
  :ensure t)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(use-package org-journal
  :ensure t
  :config (setq org-journal-date-format "%x"
                org-journal-dir "~/Documents/org-mode/journal/"
                org-journal-file-format "%Y"
                org-journal-file-type 'yearly
                org-journal-find-file-fn 'find-file
                org-journal-follow-mode t
                org-journal-hide-entries-p nil
                org-journal-time-format ""))

;; This has ob-j for literate J
(use-package org-contrib
  :ensure t
  :config (setq-default j-console-cmd "jconsole"
                        j-console-cmd-buffer-name "J Console"))

(use-package ob-async
  :ensure t)

(use-package org-appear
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-appear-mode)
  (setq org-appear-delay 1))

(use-package org-download
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'org-download-enable))

(require 'org-pretty-table)
;; Turn on org-pretty-table-mode and call iw-buffer-face-hasklig
;; to get the tables to look good.

(require 'org-yt)

(provide 'iw-org)
;;; iw-org.el ends here
