;;; iw-git.el --- git config                         -*- lexical-binding: t; -*-

;; Copyright (C) 2020  test

;; Author: test <test@subversion.local>
;; Keywords: tools

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
;; TODO consider git-timemachine https://gitlab.com/pidu/git-timemachine
(require 'use-package)
;;; Code:

(use-package gitconfig-mode
  :ensure t)

(use-package gitignore-mode
  :ensure t)

(use-package git-gutter
  :ensure t
  :init (global-git-gutter-mode +1)
  :delight)

(use-package magit
  :ensure t
  :config
  (bind-keys :prefix "C-c g"
             :prefix-map my-magit-map
             ("b" . magit-blame)))

;; Wandersons (bartuka) fns for creating and removing a git worktree
(defun bk/create-worktree ()
  "Help development on multiple branches."
  (interactive)
  (let* ((root-proj (projectile-project-root))
	 (proj-name (car (cdr (nreverse (split-string root-proj "/")))))
	 (dest-dir (file-name-directory (directory-file-name root-proj)))
	 (branch (ido-completing-read "Choose the branch: " (magit-list-local-branch-names)))
	 (worktree-path (concat dest-dir proj-name "-wt-" branch)))
    (magit-worktree-checkout worktree-path branch)
    (projectile-find-file)))

(defun bk/delete-worktree ()
  "Delete worktree and all its open buffers."
  (interactive)
  (let ((worktree (ido-completing-read "Choose worktree: " (magit-list-worktrees))))
    (mapc (lambda (buffer)
	    (with-current-buffer buffer
	      (let ((worktree-name (file-name-base worktree)))
		(when (string-equal (projectile-project-name) worktree-name)
		  (kill-buffer buffer)))))
	  (buffer-list))
    (magit-worktree-delete worktree)))

(provide 'iw-git)
;;; iw-git.el ends here
