;;; iw-window.el ---                                 -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;; Taken from https://github.com/e17i/emacs-config/
;; There is also some stuff there about window-display.
;;; Code:

(defun resize-window ()
  "Resize current window interactively using continuous key presses.
Keys supported:

 - shrink window vertically
 + enlarge window vertically
 { shrink window horizontally
 } enlarge window horizontally
 0 balance all frames window sizes"
  (interactive)
  (cl-macrolet ((msg ()
		  '(message "resize window (-,+,{,},0)"))
	        (lmb (fnc)
		  `(lambda () (interactive)
		     (msg)
		     ,fnc)))
    (msg)
    (set-transient-map
     (let ((tmap (make-sparse-keymap)))
       (define-key tmap "-"     (lmb (shrink-window 1)))
       (define-key tmap [up]    (lmb (shrink-window 1)))
       (define-key tmap "+"     (lmb (enlarge-window 1)))
       (define-key tmap "="     (lmb (enlarge-window 1)))
       (define-key tmap [down]  (lmb (enlarge-window 1)))
       (define-key tmap "{"     (lmb (shrink-window-horizontally 1)))
       (define-key tmap "["     (lmb (shrink-window-horizontally 1)))
       (define-key tmap [left]  (lmb (shrink-window-horizontally 1)))
       (define-key tmap "}"     (lmb (enlarge-window-horizontally 1)))
       (define-key tmap [right] (lmb (enlarge-window-horizontally 1)))
       tmap) 't)))

(use-package zygospore
  :ensure t)

(provide 'iw-window)
;;; iw-window.el ends here
