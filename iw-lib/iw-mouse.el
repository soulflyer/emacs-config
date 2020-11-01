;;; iw-mouse.el --- Enable mouse                     -*- lexical-binding: t; -*-

;; Copyright (C) 2020  test

;; Author: test <test@subversion.local>
;; Keywords: mouse

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
;; Most of this lifted from Sam Aarons emacs-live config.
;; TODO check that mouse follows window selection next time this is run as daemon

(require 'use-package)
(require 'mouse)
;;; Code:

;; mouse mode must be initialised for each new terminal
;; see http://stackoverflow.com/a/6798279/27782
(defun initialise-mouse-mode (&optional frame)
  "Initialise mouse mode for the current terminal or new FRAME."
  (if (not frame) ;; The initial call.
      (xterm-mouse-mode 1)
    ;; Otherwise called via after-make-frame-functions.
    (if xterm-mouse-mode
        ;; Re-initialise the mode in case of a new terminal.
        (xterm-mouse-mode 1))))

;; Evaluate both now (for non-daemon emacs) and upon frame creation
;; (for new terminals via emacsclient).
(initialise-mouse-mode)
(add-hook 'after-make-frame-functions 'initialise-mouse-mode)

(setq mouse-yank-at-point t)

(global-set-key [mouse-4] '(lambda ()
                             (interactive)
                             (scroll-down 1)))

(global-set-key [mouse-5] '(lambda ()
                             (interactive)
                             (scroll-up 1)))

(provide 'iw-mouse)
;;; iw-mouse.el ends here
