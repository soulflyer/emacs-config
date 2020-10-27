(require 'use-package)
(use-package expand-region
  :bind (("C-@" . er/expand-region)
         ;; The following is available by pressing C-!
         ("C-]" . er/contract-region)))
