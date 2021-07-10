;;; iw-counsel --- add counsel
;;; Commentary:
;; Worth considering ivy-prescient.el to sort the entries returned according to what has been used recently
;; and most often.
;; Include smex or counsel-M-x doesn't keep history.
;;; Code:
(require 'use-package)

(use-package smex
  :ensure t)

(use-package counsel
  :ensure t
  :config (setq ivy-count-format "%d/%d:"
                ivy-use-virtual-buffers t
                ivy-use-selectable-prompt t)

  :bind (("M-x"     . counsel-M-x )
         ("C-s"     . swiper-thing-at-point)
         ("C-x C-f" . counsel-find-file)
         ("C-h v"   . counsel-describe-variable)
         ("C-h f"   . counsel-describe-function)
	 ("C-x C-d" . ido-dired)
	 ("C-x d"   . ido-dired)
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
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

(provide 'iw-counsel)
;;; iw-counsel.el ends here
