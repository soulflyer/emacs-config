;;; iw-dired --- tweaks to dired
;;; Commentary:
;;; ls-lisp stops Dired complaining about the builtin ls not handling the Dired option.
;;; Note the use of :map within the Dired :bind.
;;; This ensures the bindings are added after dired-mode is entered.

;;; Code:
(defun dired-make-file (new-file-name)
  "Add file creation to DIRED NEW-FILE-NAME."
  (interactive "sFile name: ")
  (shell-command (concat "touch " new-file-name))
  (message "created %s" new-file-name)
  (message "major mode %s" major-mode)
  (if (string= major-mode "dired-mode")
      (revert-buffer))
  (dired-jump nil (expand-file-name new-file-name)))

(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil
      ls-lisp-verbosity '(uid))

(use-package dired
  :config (setq find-file-visit-truename t
                dired-guess-shell-alist-user '((".*" "open")))
  (defun download-enable ()
    (interactive)
    (org-download-enable)
    (message "Enabling drag and drop downloads for the current directory."))

  (defun dired-downloads ()
    "Open dired in the ~/Downloads directory"
    (interactive)
    (dired "~/Downloads"))

  (defun dired-movies ()
    "Open dired in /Volumes/Crucial/Movies"
    (interactive)
    (dired "/Volumes/Crucial/Movies"))

  (defun dired-collection ()
    "Open dired in the ~/Music/Collection directory"
    (interactive)
    (dired "~/Music/Collection"))

  (defun dired-home ()
    "Open dired in the home directory"
    (interactive)
    (dired "~"))

  (defun dired-pictures ()
    "Open dired in the ~/Pictures directory"
    (interactive)
    (dired "~/Pictures"))

  (defun dired-tmp ()
    "Open dired in /tmp"
    (interactive)
    (dired "/tmp"))

  (defun dired-bookshelf ()
    "Open dired in ~/Documents/books/bookshelf"
    (interactive)
    (dired "~/Documents/books/bookshelf"))

  (defun dired-code ()
    "Open dired in ~/Code"
    (interactive)
    (dired "~/Code"))

  (defun dired-lyrics ()
    "Open dired in ~/Documents/org-mode/lyrics"
    (interactive)
    (dired "~/Documents/org-mode/lyrics"))
  
  :bind
  (("C-x C-d" . dired)
   :map dired-mode-map
   ("f"       . dired-make-file)
   ("/"       . dired-up-directory)
   ("\\"      . dired-up-directory)
   ;;("C-s"   . swiper)
   ("1"       . dired-do-shell-command)
   ("E"       . emms-add-dired)
   ("e"       . download-enable)
   ("C-d d"   . dired-downloads)
   ("C-d c"   . dired-collection)
   ("C-d h"   . dired-home)
   ("C-d m"   . dired-movies)
   ("C-d p"   . dired-pictures)
   ("C-d t"   . dired-tmp)
   ("C-d b"   . dired-bookshelf)
   ("C-d C"   . dired-code)
   ("C-d l"   . dired-lyrics)))

(use-package openwith
  :ensure t)

(use-package dired-efap
  :ensure t
  :bind (:map dired-mode-map
              ("r"   . 'dired-efap))
  :config
  (setq dired-efap-initial-filename-selection nil))

(use-package dired-ranger
  :ensure t
  :bind (:map dired-mode-map
              ("c" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("v" . dired-ranger-paste)))

(provide 'iw-dired)
;;; iw-dired.el ends here
