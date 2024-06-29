;;; iw-counsel --- add counsel
;;; Commentary:
;; Worth considering ivy-prescient.el to sort the entries returned according to what has been used recently
;; and most often.
;; Include smex or counsel-M-x doesn't keep history.  (Trying amx instead)
;;; Code:
(require 'use-package)

(use-package smex
  :ensure t)

;; (use-package amx
;;   :ensure t
;;   :config (setq amx-history-length 40))

;; (amx-mode)

(use-package ido-completing-read+
  :ensure t)

(use-package helpful
  :ensure t
  :config
  (define-key helpful-mode-map      (kbd "M-RET")   'helpful-at-point))

(use-package counsel
  :ensure t
  :config (setq ivy-count-format "%d/%d:"
                ivy-use-virtual-buffers t
                ivy-use-selectable-prompt t
                counsel-describe-function-function #'helpful-callable
                counsel-describe-variable-function #'helpful-variable)

  :bind (("M-x"     . counsel-M-x )
         ("C-s"     . swiper-thing-at-point)
         ("C-x C-f" . counsel-find-file)
         ("C-h v"   . counsel-describe-variable)
         ("C-h f"   . counsel-describe-function)
         ("C-h k"   . helpful-key)
         ;; ido-dired and counsel-dired let me delete a path segment with one keystroke
         ("C-x C-d" . ido-dired)
	 ("C-x d"   . counsel-dired)
	 :map minibuffer-local-map
	 ("C-r"     . counsel-minibuffer-history)))

;; This causes CounselM-x to display the docstring as well as the command.
(use-package ivy-rich
  :ensure t
  :config (ivy-rich-mode 1))

;; This makes delete in ido remove a path section rather than a character.
(use-package flx-ido
  :ensure t
  :config
  (ido-mode 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

(provide 'iw-counsel)
;;; iw-counsel.el ends here
