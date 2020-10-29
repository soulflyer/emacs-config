;;; iw-expand-region --- setup expand region.
;;; Commentary:
;;; xpand and contract region are accessed using C-2 and C-1

;;; Code:
(require 'use-package)
(use-package expand-region
  :ensure t
  :bind (("C-@" . er/expand-region)
         ("C-]" . er/contract-region)))

(provide 'iw-expand-region)
;;; iw-expand-region.el ends here
