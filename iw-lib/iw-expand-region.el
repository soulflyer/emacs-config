;;; iw-expand-region --- setup expand region.
;;; Commentary:

;; Add binding to C-1 in iterm keymapping send hex codes 0x18 0x78 0x31
;; so xpand and contract region can be accessed using C-2 and C-1
;; may need something else to get this working ok in GUI emacs. FIXME

;;; Code:
(require 'use-package)
(use-package expand-region
  :ensure t
  :bind (("C-@" . er/expand-region)
         ("C-x x 1" . er/contract-region)))

(provide 'iw-expand-region)
;;; iw-expand-region.el ends here
