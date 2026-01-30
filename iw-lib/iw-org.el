;;; iw-org.el --- setup org                          -*- lexical-binding: t; -*-
;; Copyright (C) 2020  Iain Wood
;; Author: Iain Wood <iain@subversion.local>
;;; Commentary:

;;; Code:
(require 'use-package)

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
                org-image-actual-width (list 400)
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
                org-capture-templates       '(("b"
                                               "Build"
                                               plain
                                               (file "~/Documents/org-mode/notes/build.org")
                                               "** TODO [#C] %?")
                                              ("e"
                                               "Emacs"
                                               plain
                                               (file+headline "~/Documents/org-mode/notes/emacs.org" "Emacs TODOs")
                                               "** TODO [#G] %?")
                                              ("f"
                                               "FIXME"
                                               plain
                                               (file+headline "~/Documents/org-mode/notes/fixme.org" "FIXME TODOs")
                                               "** TODO [#C] %?")
                                              ("l"
                                               "Linux"
                                               plain
                                               (file+headline "~/Documents/org-mode/notes/linux.org" "Linux TODOs")
                                               "** TODO [#B] %?")
                                              ("m"
                                               "Music"
                                               plain
                                               (file+headline "~/Documents/org-mode/notes/music.org" "FIXME TODOs")
                                               "** TODO [#D] %?")
                                              ("s"
                                               "Sing use: <title>:<artist>"
                                               plain
                                               (file+headline "~/Documents/org-mode/agenda/sing.org" "Candidates")
                                               "** %?: ")
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
                                               ("\\.pdf\\'" . "evince %s")
                                               ("\\.vcv\\'" . "/usr/local/bin/Rack %s")))

  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
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
                                                           (arduino    . t)
                                                           (abc        . t)
                                                           (verb       . t)))

  (define-key org-mode-map [remap org-meta-return] 'helpful-at-point)
  
  (defun iw-lyrics-and-play ()
    (interactive)
    (iw-lyrics)
    (iw-emms-play-track))

  (defun iw-save-org-files ()
    (interactive)
    (if (not (eq nil (get-buffer "*unison*")))
        (kill-buffer "*unison*"))
    (org-save-all-org-buffers)
    (unison)
    (let ((user-input (read-string "Input for unison: " "y" "y" "y")))
      (if (get-buffer-process "*unison*")
          (process-send-string "*unison*" user-input))))

  ;; this is from https://kimi.im/2022-04-29-background-color-of-inline-image-for-orgmode
  ;; Sets the background of inline images when they are created. abc generates svg images
  ;; with transparent backgrounds and black notes. Can also add "%%bgcolor white" to header
  (defun org--create-inline-image-advice (img)
    (nconc img (list :background "#f8f8f8")))
  (advice-add 'org--create-inline-image
              :filter-return #'org--create-inline-image-advice)

  :bind (("C-c o" . org-agenda)
         :map org-mode-map
         ("C-c i"   . org-insert-structure-template)
         ("C-c C-o" . org-agenda-open-link)
         ("RET"     . iw-zetteldeft-return)
         ("C-c SPC SPC" . iw-lyrics)
         ("C-c SPC RET" . iw-emms-play-track)
         ("C-c l"   . iw-lyrics)
         ([f6]      . iw-lyrics-and-play)))

;; Redefine some fns so org capture stays in one window
(with-eval-after-load "org"
  (defun org-capture-fill-template (&optional template initial annotation)
    "Fill a TEMPLATE and return the filled template as a string.
The template may still contain \"%?\" for cursor positioning.
INITIAL content and/or ANNOTATION may be specified, but will be overridden
by their respective `org-store-link-plist' properties if present.

Expansion occurs in a temporary Org mode buffer."
    (let* ((template (or template (org-capture-get :template)))
	   (buffer (org-capture-get :buffer))
	   (file (buffer-file-name (or (buffer-base-buffer buffer) buffer)))
	   (time (let* ((c (or (org-capture-get :default-time) (current-time)))
		        (d (decode-time c)))
		   (if (< (nth 2 d) org-extend-today-until)
		       (org-encode-time 0 59 23 (1- (nth 3 d)) (nth 4 d) (nth 5 d))
		     c)))
	   (v-t (format-time-string (org-time-stamp-format nil) time))
	   (v-T (format-time-string (org-time-stamp-format t) time))
	   (v-u (format-time-string (org-time-stamp-format nil t) time))
	   (v-U (format-time-string (org-time-stamp-format t t) time))
	   (v-c (and kill-ring (current-kill 0)))
	   (v-x (or (org-get-x-clipboard 'PRIMARY)
		    (org-get-x-clipboard 'CLIPBOARD)
		    (org-get-x-clipboard 'SECONDARY)
		    ""))			;ensure it is a string
	   ;; `initial' and `annotation' might have been passed.  But if
	   ;; the property list has them, we prefer those values.
	   (v-i (or (plist-get org-store-link-plist :initial)
		    (and (stringp initial) (org-no-properties initial))
		    (org-capture-get :initial)
		    ""))
	   (v-a
	    (let ((a (or (plist-get org-store-link-plist :annotation)
		         annotation
		         (org-capture-get :annotation)
		         "")))
	      ;; Is the link empty?  Then we do not want it...
	      (if (equal a "[[]]") "" a)))
	   (l-re "\\[\\[\\(.*?\\)\\]\\(\\[.*?\\]\\)?\\]")
	   (v-A (if (and v-a (string-match l-re v-a))
		    (replace-match "[[\\1][%^{Link description}]]" nil nil v-a)
		  v-a))
	   (v-l (if (and v-a (string-match l-re v-a))
		    (replace-match "[[\\1]]" nil nil v-a)
		  v-a))
	   (v-L (if (and v-a (string-match l-re v-a))
		    (replace-match "\\1" nil nil v-a)
		  v-a))
	   (v-n user-full-name)
	   (v-k (if (marker-buffer org-clock-marker)
		    (org-no-properties org-clock-heading)
		  ""))
	   (v-K (if (marker-buffer org-clock-marker)
		    (org-link-make-string
		     (format "%s::*%s"
			     (buffer-file-name (marker-buffer org-clock-marker))
			     v-k)
		     v-k)
		  ""))
	   (v-f (or (org-capture-get :original-file-nondirectory) ""))
	   (v-F (or (org-capture-get :original-file) ""))
	   (org-capture--clipboards
	    (delq nil
		  (list v-i
		        (org-get-x-clipboard 'PRIMARY)
		        (org-get-x-clipboard 'CLIPBOARD)
		        (org-get-x-clipboard 'SECONDARY)
		        v-c))))
      (setq org-store-link-plist (plist-put org-store-link-plist :annotation v-a))
      (setq org-store-link-plist (plist-put org-store-link-plist :initial v-i))
      (unless template
        (setq template "")
        (message "no template") (ding)
        (sit-for 1))
      (save-window-excursion
        ;;(org-switch-to-buffer-other-window (get-buffer-create "*Capture*"))
        (org-pop-to-buffer-same-window (get-buffer-create "*Capture*"))
        (erase-buffer)
        (setq buffer-file-name nil)
        (setq mark-active nil)
        (insert template)
        (org-mode)
        (goto-char (point-min))
        ;; %[] insert contents of a file.
        (save-excursion
	  (while (re-search-forward "%\\[\\(.+\\)\\]" nil t)
	    (let ((filename (expand-file-name (match-string 1)))
		  (beg (copy-marker (match-beginning 0)))
		  (end (copy-marker (match-end 0))))
	      (unless (org-capture-escaped-%)
	        (delete-region beg end)
	        (set-marker beg nil)
	        (set-marker end nil)
	        (condition-case error
		    (insert-file-contents filename)
		  (error
		   (insert (format "%%![could not insert %s: %s]"
				   filename
				   error))))))))
        ;; Mark %() embedded elisp for later evaluation.
        (org-capture-expand-embedded-elisp 'mark)
        ;; Expand non-interactive templates.
        (let ((regexp "%\\(:[-A-Za-z]+\\|<\\([^>\n]+\\)>\\|[aAcfFikKlLntTuUx]\\)"))
	  (save-excursion
	    (while (re-search-forward regexp nil t)
	      ;; `org-capture-escaped-%' may modify buffer and cripple
	      ;; match-data.  Use markers instead.  Ditto for other
	      ;; templates.
	      (let ((pos (copy-marker (match-beginning 0)))
		    (end (copy-marker (match-end 0)))
		    (value (match-string 1))
		    (time-string (match-string 2)))
	        (unless (org-capture-escaped-%)
		  (delete-region pos end)
		  (set-marker pos nil)
		  (set-marker end nil)
		  (let* ((inside-sexp? (org-capture-inside-embedded-elisp-p))
		         (replacement
			  (pcase (string-to-char value)
			    (?< (format-time-string time-string time))
			    (?:
			     (or (plist-get org-store-link-plist (intern value))
			         ""))
			    (?i
			     (if inside-sexp? v-i
			       ;; Outside embedded Lisp, repeat leading
			       ;; characters before initial place holder
			       ;; every line.
			       (let ((lead (concat "\n"
						   (org-current-line-string t))))
			         (replace-regexp-in-string "\n" lead v-i nil t))))
			    (?a v-a)
			    (?A v-A)
			    (?c v-c)
			    (?f v-f)
			    (?F v-F)
			    (?k v-k)
			    (?K v-K)
			    (?l v-l)
			    (?L v-L)
			    (?n v-n)
			    (?t v-t)
			    (?T v-T)
			    (?u v-u)
			    (?U v-U)
			    (?x v-x))))
		    (insert
		     (if inside-sexp?
		         ;; Escape sensitive characters.
		         (replace-regexp-in-string "[\\\"]" "\\\\\\&" replacement)
		       replacement))))))))
        ;; Expand %() embedded Elisp.  Limit to Sexp originally marked.
        (org-capture-expand-embedded-elisp)
        ;; Expand interactive templates.  This is the last step so that
        ;; template is mostly expanded when prompting happens.  Turn on
        ;; Org mode and set local variables.  This is to support
        ;; completion in interactive prompts.
        (let ((org-inhibit-startup t)) (org-mode))
        (org-clone-local-variables buffer "\\`org-")
        (let (strings)			; Stores interactive answers.
	  (save-excursion
	    (let ((regexp "%\\^\\(?:{\\([^}]*\\)}\\)?\\([CgGLptTuU]\\)?"))
	      (while (re-search-forward regexp nil t)
	        (let* ((items (and (match-end 1)
				   (save-match-data
				     (split-string (match-string-no-properties 1)
						   "|"))))
		       (key (match-string 2))
		       (beg (copy-marker (match-beginning 0)))
		       (end (copy-marker (match-end 0)))
		       (prompt (nth 0 items))
		       (default (nth 1 items))
		       (completions (nthcdr 2 items)))
		  (unless (org-capture-escaped-%)
		    (delete-region beg end)
		    (set-marker beg nil)
		    (set-marker end nil)
		    (pcase key
		      ((or "G" "g")
		       (let* ((org-last-tags-completion-table
			       (org-global-tags-completion-table
			        (cond ((equal key "G") (org-agenda-files))
				      (file (list file))
				      (t nil))))
			      (org-add-colon-after-tag-completion t)
			      (ins (mapconcat
				    #'identity
				    (let ((crm-separator "[ \t]*:[ \t]*"))
                                      (completing-read-multiple
				       (if prompt (concat prompt ": ") "Tags: ")
				       org-last-tags-completion-table nil nil nil
				       'org-tags-history))
				    ":")))
		         (when (org-string-nw-p ins)
			   (unless (eq (char-before) ?:) (insert ":"))
			   (insert ins)
			   (unless (eq (char-after) ?:) (insert ":"))
			   (when (org-at-heading-p) (org-align-tags)))))
		      ((or "C" "L")
		       (let ((insert-fun (if (equal key "C") #'insert
					   (lambda (s) (org-insert-link 0 s)))))
		         (pcase org-capture--clipboards
			   (`nil nil)
			   (`(,value) (funcall insert-fun value))
			   (`(,first-value . ,_)
			    (funcall insert-fun
				     (read-string "Clipboard/kill value: "
						  first-value
						  'org-capture--clipboards
						  first-value)))
			   (_ (error "Invalid `org-capture--clipboards' value: %S"
				     org-capture--clipboards)))))
		      ("p"
		       ;; We remove keyword properties inherited from
		       ;; target buffer so `org-read-property-value' has
		       ;; a chance to find allowed values in sub-trees
		       ;; from the target buffer.
		       (setq-local org-keyword-properties nil)
		       (let* ((origin (set-marker (make-marker)
						  (org-capture-get :pos)
						  (org-capture-get :buffer)))
			      ;; Find location from where to get allowed
			      ;; values.  If `:target-entry-p' is
			      ;; non-nil, the current headline in the
			      ;; target buffer is going to be a parent
			      ;; headline, so location is fine.
			      ;; Otherwise, find the parent headline in
			      ;; the target buffer.
			      (pom (if (org-capture-get :target-entry-p) origin
				     (let ((level (progn
						    (while (org-up-heading-safe))
						    (org-current-level))))
				       (org-with-point-at origin
				         (let ((l (if (org-at-heading-p)
						      (org-current-level)
						    most-positive-fixnum)))
					   (while (and l (>= l level))
					     (setq l (org-up-heading-safe)))
					   (if l (point-marker)
					     (point-min-marker)))))))
			      (value
			       (org-read-property-value prompt pom default)))
		         (org-set-property prompt value)))
		      ((or "t" "T" "u" "U")
		       ;; These are the date/time related ones.
		       (let* ((upcase? (equal (upcase key) key))
			      (org-end-time-was-given nil)
			      (time (org-read-date upcase? t nil prompt)))
		         (org-insert-time-stamp
			  time (or org-time-was-given upcase?)
			  (member key '("u" "U"))
			  nil nil (list org-end-time-was-given))))
		      (`nil
		       ;; Load history list for current prompt.
		       (setq org-capture--prompt-history
			     (gethash prompt org-capture--prompt-history-table))
                       (push (org-completing-read
                              (org-format-prompt (or prompt "Enter string") default)
			      completions
			      nil nil nil 'org-capture--prompt-history default)
			     strings)
		       (insert (car strings))
		       ;; Save updated history list for current prompt.
		       (puthash prompt org-capture--prompt-history
			        org-capture--prompt-history-table))
		      (_
		       (error "Unknown template placeholder: \"%%^%s\""
			      key))))))))
	  ;; Replace %n escapes with nth %^{...} string.
	  (setq strings (nreverse strings))
	  (save-excursion
	    (while (re-search-forward "%\\\\\\([1-9][0-9]*\\)" nil t)
	      (unless (org-capture-escaped-%)
	        (replace-match
	         (nth (1- (string-to-number (match-string 1))) strings)
	         nil t)))))
        ;; Make sure there are no empty lines before the text, and that
        ;; it ends with a newline character or it is empty.
        (skip-chars-forward " \t\n")
        (delete-region (point-min) (line-beginning-position))
        (goto-char (point-max))
        (skip-chars-backward " \t\n")
        (if (bobp) (delete-region (point) (line-end-position))
	  (end-of-line)
	  (delete-region (point) (point-max))
	  (insert "\n"))
        ;; Return the expanded template and kill the capture buffer.
        (untabify (point-min) (point-max))
        (set-buffer-modified-p nil)
        (prog1 (buffer-substring-no-properties (point-min) (point-max))
	  (kill-buffer (current-buffer))))))
  (defun org-capture-place-template (&optional inhibit-wconf-store)
    "Insert the template at the target location, and display the buffer.
When INHIBIT-WCONF-STORE is non-nil, don't store the window configuration, as it
may have been stored before."
    (unless inhibit-wconf-store
      (org-capture-put :return-to-wconf (current-window-configuration)))
    (delete-other-windows)
    (org-pop-to-buffer-same-window
     (org-capture-get-indirect-buffer (org-capture-get :buffer) "CAPTURE"))
    (widen)
    (org-fold-show-all)
    (goto-char (org-capture-get :pos))
    (setq-local outline-level 'org-outline-level)
    (pcase (org-capture-get :type)
      ((or `nil `entry) (org-capture-place-entry))
      (`table-line (org-capture-place-table-line))
      (`plain (org-capture-place-plain-text))
      (`item (org-capture-place-item))
      (`checkitem (org-capture-place-item)))
    (setq-local org-capture-current-plist org-capture-plist)
    (org-capture--run-template-functions :hook 'local)
    (org-capture-mode 1))
  (defun org-mks (table title &optional prompt specials)
    "Select a member of an alist with multiple keys.

TABLE is the alist which should contain entries where the car is a string.
There should be two types of entries.

1. prefix descriptions like (\"a\" \"Description\")
   This indicates that `a' is a prefix key for multi-letter selection, and
   that there are entries following with keys like \"ab\", \"ax\"...

2. Select-able members must have more than two elements, with the first
   being the string of keys that lead to selecting it, and the second a
   short description string of the item.

The command will then make a temporary buffer listing all entries
that can be selected with a single key, and all the single key
prefixes.  When you press the key for a single-letter entry, it is selected.
When you press a prefix key, the commands (and maybe further prefixes)
under this key will be shown and offered for selection.

TITLE will be placed over the selection in the temporary buffer,
PROMPT will be used when prompting for a key.  SPECIALS is an
alist with (\"key\" \"description\") entries.  When one of these
is selected, only the bare key is returned."
    (save-window-excursion
      (let ((inhibit-quit t)
            (buffer (org-pop-to-buffer-same-window "*Org Select*"))
            (prompt (or prompt "Select: "))
            case-fold-search
            current)
        (unwind-protect
            (catch 'exit
              (while t
                (erase-buffer)
                (insert title "\n\n")
                (let ((des-keys nil)
                      (allowed-keys '("\C-g"))
                      (tab-alternatives '("\s" "\t" "\r"))
                      (cursor-type nil))
                  ;; Populate allowed keys and descriptions keys
                  ;; available with CURRENT selector.
                  (let ((re (format "\\`%s\\(.\\)\\'"
                                    (if current (regexp-quote current) "")))
                        (prefix (if current (concat current " ") "")))
                    (dolist (entry table)
                      (pcase entry
                        ;; Description.
                        (`(,(and key (pred (string-match re))) ,desc)
                         (let ((k (match-string 1 key)))
                           (push k des-keys)
                           ;; Keys ending in tab, space or RET are equivalent.
                           (if (member k tab-alternatives)
                               (push "\t" allowed-keys)
                             (push k allowed-keys))
                           (insert prefix "[" k "]" "..." "  " desc "..." "\n")))
                        ;; Usable entry.
                        (`(,(and key (pred (string-match re))) ,desc . ,_)
                         (let ((k (match-string 1 key)))
                           (insert prefix "[" k "]" "     " desc "\n")
                           (push k allowed-keys)))
                        (_ nil))))
                  ;; Insert special entries, if any.
                  (when specials
                    (insert "----------------------------------------------------\
---------------------------\n")
                    (pcase-dolist (`(,key ,description) specials)
                      (insert (format "[%s]     %s\n" key description))
                      (push key allowed-keys)))
                  ;; Display UI and let user select an entry or
                  ;; a sub-level prefix.
                  (goto-char (point-min))
                  (org-fit-window-to-buffer)
                  (message "") ; With this line the prompt appears in
                                        ; the minibuffer. Else keystrokes may
                                        ; appear, which is spurious.
                  (let ((pressed (org--mks-read-key
                                  allowed-keys prompt
                                  (not (pos-visible-in-window-p (1- (point-max)))))))
                    (setq current (concat current pressed))
                    (cond
                     ((equal pressed "\C-g") (user-error "Abort"))
                     ;; Selection is a prefix: open a new menu.
                     ((member pressed des-keys))
                     ;; Selection matches an association: return it.
                     ((let ((entry (assoc current table)))
                        (and entry (throw 'exit entry))))
                     ;; Selection matches a special entry: return the
                     ;; selection prefix.
                     ((assoc current specials) (throw 'exit current))
                     (t (error "No entry available")))))))
          (when buffer (kill-buffer buffer))))))
  )

(add-hook 'org-agenda-mode-hook
          (lambda ()
            (local-set-key (kbd "S") 'iw-save-org-files)))

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
  :config (setq org-attach-screenshot-dirfunction 'iw-dirfunction))

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

(use-package org-modern
  :ensure t)

(use-package unison
  :ensure t
  :config
  (setq unison-args '("org-mode")
        org-modern-fold-stars '(("⯈" . "🟩")
                                ("⯈" . "⯀")
                                ("▶" . "■")
                                ("▷" . "□")
                                ("▹" . "▫")
                                ("▸" . "▫"))
        org-modern-priority nil
        org-modern-todo nil))

;; (defun iw-save-org-files ()
;;   (interactive)
;;   (org-save-all-org-buffers)
;;   (unison)
;;   (let ((user-input (read-string "Input for unison:")))
;;     (if (get-buffer-process "*unison*")
;;         (process-send-string "*unison*" user-input)
;;       (kill-buffer "*unison*"))))

;; (keymap-unset org-agenda-mode-map "S")
;; (keymap-set org-agenda-mode-map "S" 'iw-save-org-files)

(provide 'iw-org)
;;; iw-org.el ends here
