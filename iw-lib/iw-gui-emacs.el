;;; iw-gui-emacs.el ---                              -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;; Code:
(message "Running GUI Emacs config")

(add-to-list 'default-frame-alist '(undecorated . t))
(set-face-attribute 'default nil :height 140)
(when (member "MonacoB2" (font-family-list))
  (set-frame-font "MonacoB2" t t))
(when (member "Apple Color Emoji" (font-family-list))
  (set-fontset-font
   t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend))

;; Some things don't get applied if run at server startup and have to be run run when emacsclient starts a frame.
;; from https://emacs.stackexchange.com/a/62220/2666
(defun init-gui-frame ()
  (when (member "MonacoB2" (font-family-list))
    (set-frame-font "MonacoB2" t t))
  (set-fontset-font t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend)
  (add-to-list 'face-font-rescale-alist
               (cons (font-spec :family "Apple Color Emoji") 0.92) t)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
  (setq-default rainbow-html-colors nil
                rainbow-r-colors nil
                rainbow-x-colors nil
                cursor-in-non-selected-windows '(hbar . 1)
                cursor-type 'bar)
  (setq frame-resize-pixelwise t))

(add-hook
 'server-after-make-frame-hook
 (let (done)
   (lambda ()
     (unless done
       ;; still set done to true even if we hit a bug (otherwise we
       ;; can never open a frame to see the problem)
       (setq done t)
       (init-gui-frame)))))

(blink-cursor-mode 0)
(setq
 cursor-type 'bar
 cursor-in-non-selected-windows '(hbar . 1))

(defun iw-set-font-size ()
  "Adjust the font size in all windows."
  (interactive)
  (let (font-size)
    (setq font-size (read-number "Text size: "))
    (set-frame-font (font-spec :size font-size) t `(,(selected-frame)))))

(use-package font-utils
  :ensure t)


(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))

(provide 'iw-gui-emacs)
;;; iw-gui-emacs.el ends here
