;;; iw-spell.el ---                                  -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;; Code:

(setq-default ispell-program-name "aspell")

(use-package flyspell-correct-avy-menu
  :ensure t
  :bind ("M-s s" . flyspell-correct-at-point)
  :init
  (setq flyspell-correct-interface #'flyspell-correct-avy-menu
        ispell-dictionary "en"))

(provide 'iw-spell)
;;; iw-spell.el ends here
