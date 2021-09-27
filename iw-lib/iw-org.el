;;; iw-org.el --- setup org                          -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Iain Wood

;; Author: Iain Wood <iain@subversion.local>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

(require 'use-package)
;;; Code:

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
  :config
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
        org-taxonomy-file           "~/Documents/org-mode/plans/taxonomy.org"
        org-capture-templates
        '(("e" "Emacs" entry (file "~/Documents/org-mode/notes/emacs.org"))
          ("s" "Study" entry (file "~/Documents/org-mode/notes/study.org"))
          ("p" "Plan"  entry (file "~/Documents/org-mode/plans/plan.org")
           "* TODO %?%i [/]")
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
           "* %?%i")))

  (define-key org-mode-map [remap org-meta-return] 'live-lisp-describe-thing-at-point)
  :bind (("C-c o" . org-agenda)
         :map org-mode-map
         ("C-c i" . org-insert-structure-template)
         ("C-c C-o" . org-agenda-open-link)))

(add-hook 'calendar-initial-window-hook 'diary-mark-entries)

;; TODO I think this should be in :config with a mention of 'calendar in :commands.
(global-set-key (kbd "C-c c") 'calendar)
(provide 'iw-org)
;;; iw-org.el ends here
