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
                org-habit-show-all-today t)
  (add-to-list 'display-buffer-alist
               '("*Agenda Commands*" display-buffer-at-bottom))
  :config
  (defun iw-zetteldeft-return ()
    (interactive)
    (let ((in-thing (if (thing-at-point 'symbol)
                        (save-excursion
                          (beginning-of-thing 'symbol)
                          (cond
                           ((and (not (string= "+" (thing-at-point 'char 'no-properties)))
                                 (= (char-before) 35)) "tag")
                           ((= (char-before) 167) "link")
                           (t                      nil))))))
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
  (setq org-return-follows-link t
        org-refile-targets          '((org-agenda-files :tag . ""))
        org-refile-use-outline-path 'file
        org-log-done                'time
        org-default-notes-file      "~/Documents/org-mode/notes/new-notes"
        org-taxonomy-file           "~/Documents/org-mode/plans/taxonomy.org"
        org-capture-templates       '(("e"
                                       "Emacs"
                                       plain
                                       (file "~/Documents/org-mode/notes/emacs.org")
                                       "** TODO [#G] %?")
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
                                       (file "~/Documents/org-mode/notes/study.org")
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
                                       ("c" "Capture" org-capture "" nil)))
  (org-babel-do-load-languages 'org-babel-load-languages '((ditaa  . t)
                                                           (python . t)
                                                           (shell  . t)))
  (define-key org-mode-map [remap org-meta-return] 'live-lisp-describe-thing-at-point)
  :bind (("C-c o" . org-agenda)
         :map org-mode-map
         ("C-c i"   . org-insert-structure-template)
         ("C-c C-o" . org-agenda-open-link)
         ("RET"     . iw-zetteldeft-return)))

(add-hook 'calendar-initial-window-hook 'diary-mark-entries)

;; TODO I think this should be in :config with a mention of 'calendar in :commands.
(global-set-key (kbd "C-c c") 'calendar)
(provide 'iw-org)
;;; iw-org.el ends here
