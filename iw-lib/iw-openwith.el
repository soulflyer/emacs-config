;;; iw-openwith.el --- setup openwith                -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Iain Wood

;; Author: Iain Wood <iain@soulflyer.co.uk>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;
(require 'use-package)
;;; Code:

(use-package openwith
  :ensure t
  :init
  (setq openwith-associations '(("\\.\\(png\\|jp?g\\|pdf\\)\\'" "open" (file))
                                ("\\.torrent\\'" "open" (file))
                                ("\\.\\(mp3\\|avi\\|wmv\\)\\'" "vlc" (file))
                                ("\\.\\(doc\\|odt\\|xls\\|ods\\|ppt\\|odp\\)\\'" "open" (file))))
  :config
  (openwith-mode t))

(provide 'iw-openwith)
;;; iw-openwith.el ends here
