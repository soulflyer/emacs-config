;;; iw-completion.el ---                             -*- lexical-binding: t; -*-
;; Copyright (C) 2023  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:
(use-package company
  :ensure t
  :config
  (global-company-mode -1)
  (setq-default
   company-idle-delay 1.05
   company-require-match nil
   company-minimum-prefix-length 0
   
   ;; get only preview
   ;; company-frontends '(company-preview-frontend)
   ;; also get a drop down
   company-frontends '(company-pseudo-tooltip-frontend company-preview-frontend)
   ))

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (global-auto-complete-mode t))

;; (use-package company-tabnine :ensure t)
;; (add-to-list 'company-backends #'company-tabnine)

;; ;; we recommend using use-package to organize your init.el
;; (use-package codeium
;;   ;; if you use straight
;;   ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
;;   ;; otherwise, make sure that the codeium.el file is on load-path

;;   :init
;;   ;; use globally
;;   (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
;;   :config
;;   ;;(setq use-dialog-box nil) ;; do not use popup boxes

;;   ;; get codeium status in the modeline
;;   (setq codeium-mode-line-enable
;;         (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))

;;   ;;(add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
;;   ;; alternatively for a more extensive mode-line
;;   (add-to-list 'mode-line-format '(-50 "" codeium-mode-line) t))

(provide 'iw-completion)
;;; iw-ai.el ends here
