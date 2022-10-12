;;; iw-tab.el ---                                    -*- lexical-binding: t; -*-
;; Copyright (C) 2022  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(defun tab-calendar ()
  "Open the calendar and diary in a new tab if 'tab-bar-mode' is on.  Otherwise just open the calendar."
  (if (not tab-bar-mode)
      (calendar)
    (tab-create "Calendar")
    (calendar)
    (diary-show-all-entries)
    (scroll-other-window-down)))

(provide 'iw-tab)
;;; iw-tab.el ends here
