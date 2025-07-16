(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-timeout-seconds 1.0)
 '(cider-injected-nrepl-version "1.1.2")
 '(connection-local-criteria-alist
   '(((:application tramp :machine "acceptance")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp :protocol "kubernetes")
      tramp-kubernetes-connection-local-default-profile)
     ((:application eshell)
      eshell-connection-default-profile)
     ((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile tramp-flatpak-connection-local-default-profile)
     ((:application tramp :machine "localhost")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp :machine "acceptance.local")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((tramp-flatpak-connection-local-default-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-kubernetes-connection-local-default-profile
      (tramp-config-check . tramp-kubernetes--current-context-data)
      (tramp-extra-expand-args 97
                               (tramp-kubernetes--container
                                (car tramp-current-connection))
                               104
                               (tramp-kubernetes--pod
                                (car tramp-current-connection))
                               120
                               (tramp-kubernetes--context-namespace
                                (car tramp-current-connection))))
     (eshell-connection-default-profile
      (eshell-path-env-list))
     (tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))))
 '(custom-safe-themes
   '("21c03755bb86db9ae6bd495f993512a79fb29cd897e10cd926b0a9a9d877e30c" "8aea5fd8c8e82e6bc5905c94b38fbae723bd085ae85bcdedd431ac6e17a124d0" "29c87a70dac9bcf09b5f9c388a966baabda8ac05b4f6d4fd8eab70ef499956ce" "37eabe7f263d1cd74c06d171e7098e235a9d75b45751dc35b3d32b5b39f924ca" "25f806ae079fbab1d8703d706f14e4c510fa5cefcb37501e8332b5e396bcb4a5" "73fa0c34e61928d89ebaac3660cd4d0146c2eac2c229bf4e5a543ce6f8b54b5a" "d8296be818ed46a5145ae461e18f51fd22bcb5b6ad621bd83d8a50e75260a619" "963957edd6afae2a1afcb12e9795b232bb32f44981cd1230b9c12975098201a8" "af8671dbedfa4c99b65aab6df08aa9ee248234f973db9e6da447086f8c9ea57a" "416bc809dec4f6ad384e12013d828361888e6853261e3ba8404ba44fdc892637" "fdcce9f24f74919a3df842f489a24054871db39e5fe7444bdfd943866e3edb37" "66768b02ebe0737cfe162853ceb65e2fd114efb294121ba54d9fe261855d1a44" "f23823aad4ab6eb1cd4dd50e81a83178d6a904a73cf75f6dc44e09bdf49c0a6f" "f0170ccdc201edb22df40c406b82d29eb8cf9366f0558d02ff701ba468a339bf" "c9f9eae036b11632ccee7529d3d5a3e19448e2db125113089f8ad24bc3500229" "d43e1b82f5de96438a175e0a64c7182e84d7500c1ad3f739cac4daa47027ba5b" "e5cc295cec49533e1334e894ecc9499c32ba0d9a0c309258c7261de32be06896" "addd5296d929e082ade5485387ffa089bd832825c969d079194c218b53b3e8d0" "4e579f76a9bb574770eb7ca64dcccd168a073c4ba1b11707c7af6916bbcec83a" "5f1499dabc17f760004fccd78f28496e41bd9e0aa947a4e6bc600ebc30c98eed" "059ac18b16c7a35472cb0c507afe383f2bb6c0cc1f30fd073826107453deba6c" "d36ea9e957f4159880761eb7d315f1e31ed35d85ea201c28fa6a974978088846" "2f9f89f2b4f3be6ff54dbf4ba827696d5ec813b73bc9cdbae89154884d175502" "7a55ea8d8e3828518e24c8a520d49e3985b9a806e3ecfb38883ab8f000fb397f" "a75424240a68fa62d501f8150a873283d3637cf895ed10f71de5417af3c9fd5c" "5b731f3cd5c48649cb1ed5cad104f471354c6950c9add389824e8482b789664f" "556eabe2d2503f1bb28ffab25ed3957000238f3781ba913bab806ebbbf71d7b2" "8d2c6257eca0f470a3231177fddc5b0c4912c4eff1a73408c7156b50b1a2a602" "e8a1f1216943d2b2b9fbe7fbb642478b2ba86e7ccc7d75ce9d10033c7dff8796" "b866488b6cebf8bd90ff4b22b777c082f7d551f446049e730e011e386763a2dc" "403573f8aec8d00907ef92db6fc5abfe6accf98312bdab8e331d0bb8b05899e7" "2938efaf46bb2c8468703f60d34349cc2ce387a3011190cbb1ed1efd4e1d28e4" "a3dae57a3cd84ad1a40bb6adbb769f425556e48dfeb7477600ff2110575495af" "68e74f8c8f9278754c863e4cc1a23b1cae22af7a5f5b1952f1e3ca28a65a37d9" "eb15c54b3a31b78fe05714650a854dc2861a5d5f59454968d08f7da538e1a34f" "ecd6a2b27fd940d2a41f0ff560a368cf4101c7e15cd01c064e1f734d25784621" "2a0b6e21ea7c565f39f5197c153d4d289b0a347e7514dc2fb3d4b627f7fa1d5a" "0fff397bc3488b083580f963215c47a0bfeedd97dccd2303a7041bba5257e581" "93b0dbb124a2e716ff4b12f148b9147e6f308b7436556677e0eb2cd1924022d0" "67544a979ecfbc12719b2b8d40ba78c7ee487e392102ca39663c2d7d6e03b6ce" "2ce9803cc084659ba3cbc453561ae3b7956713ea4a5f65d744238084b35bdc02" default))
 '(deft-strip-summary-regexp
   "\\([\12\11]\\|^#\\+[[:upper:]_]+:.*$\\|:[[:upper:]_]+.*$\\|^#[ ]*[Tags|TAGS].*$\\)")
 '(emms-track-description-function 'iw-emms-info-track-description)
 '(eval-expression-print-length nil)
 '(flycheck-disabled-checkers '(emacs-lisp-checkdoc))
 '(history-length 10000)
 '(list-command-history-max nil)
 '(lyrics-backend 'lyrics-azlyrics)
 '(org-attach-use-inheritance t)
 '(org-babel-lilypond-commands '("/opt/homebrew/bin/lilypond" "open" "open"))
 '(org-download-screenshot-method "screencapture -i %s")
 '(org-download-timestamp "")
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus org-habit ol-info ol-irc ol-mhe ol-rmail ol-w3m))
 '(org-pretty-table-charset "╒╕╘╛╤╡╧╞╪═│")
 '(package-selected-packages
   '(arduino-cli-mode arduino-mode bln-mode smex clj-refactor eat org-noter-pdftools org-pdftools pdf-tools multiple-cursors haskell-mode feature-mode persistent-scratch org-appear elpy groovy-mode flycheck-clojure inf-clojure align-cljlet cider clojure-mode magit minimap ob-async org-async with-editor user-keys company-tabnine wanderlust w3m mew blimp markdown-mode fzf zygospore free-keys font-utils xwwp projectile typescript-mode flycheck deft vterm ace-jump-mode abc-mode org-pdf-tools hyperspace git-modes nov impatient-showdown ido-completing-read+ org-contrib ob-translate ob-applescript j-mode org-journal org-attach-screenshot org-download gnu-apl-mode lsp-docker emojify emoji-cheat-sheet-plus helpful ccls eshell-vterm eshell-syntax-highlighting git-timemachine org-superstar lsp-treemacs lsp-origami lsp-ivy lsp-ui lsp-mode zetteldeft yaml-mode yaml xwwp-follow-link-ivy xhair xah-get-thing workgroups2 which-key web-mode visual-regexp visual-ascii-mode visible-mark verb unidecode unicode-fonts undo-tree underline-with-char ts-comint treemacs tide sx string-inflection smartparens shackle ripgrep register-list rainbow-mode rainbow-delimiters quelpa-use-package prog-fill popwin paradox palimpsest paced osx-dictionary origami org-roam org-cliplink openwith ob-mongo nvm neil multi-vterm mongo make-color lyrics lorem-ipsum load-bash-alias lively launchctl jump-char js-comint ivy-rich iregister ibuffer-git howdoyou horoscope hl-todo highlight-indent-guides highlight-context-line goto-last-change goto-char-preview google-translate go-translate gitignore-mode gitconfig-mode git-gutter flyspell-correct-avy-menu flx-ido fira-code-mode face-explorer exwm expand-region exec-path-from-shell eterm-256color eshell-prompt-extras eshell-git-prompt edwina eaf dynamic-spaces direnv dired-ranger dired-efap delight dashboard dark-souls dap-mode crdt counsel-web counsel-projectile counsel-dash company command-log-mode cljstyle-format burly browse-kill-ring bm beacon banner-comment back-button auto-complete auto-compile ascii-table ascii-art-to-unicode applescript-mode annotate amx aggressive-indent ace-mc ace-jump-buffer a))
 '(projectile-globally-unignored-files nil)
 '(projectile-indexing-method 'alien)
 '(safe-local-variable-values
   '((project-colour . "#44aaff")
     (project-colour . "#9e0404")
     (project-colour . "#deb887")
     (project-colour . "#ff7f00")
     (project-colour . "#d02040")
     (project-colour . "#d0d040")
     (project-colour . "#d020d0")
     (project-colour . "#4080ff")
     (project-colour . "#4040ff")
     (project-colour . "#000088")
     (project-colour . "#2030d0")
     (project-colour . "#20d030")
     (project-colour . "#d02030")
     (eval progn
           (make-variable-buffer-local 'cider-jack-in-nrepl-middlewares)
           (add-to-list 'cider-jack-in-nrepl-middlewares "shadow.cljs.devtools.server.nrepl/middleware"))
     (sql-connection-alist
      (lui-dev
       (sql-product 'postgres)
       (sql-database "postgresql://lui:dev@localhost:5463/lui")))
     (cider-jack-in-cljs-nrepl-middlewares "shadow.cljs.devtools.server.nrepl/middleware")
     (sql-postgres-login-params)
     (sql-product . postgres)))
 '(savehist-file "~/.emacs-history")
 '(warning-minimum-level :error)
 '(warning-suppress-types '((emacs) (org)))
 '(web-mode-attr-indent-offset 2)
 '(web-mode-attr-value-indent-offset 2)
 '(web-mode-enable-auto-expanding t)
 '(web-mode-enable-auto-indentation t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(emms-browser-album-face ((t (:foreground "#4c83ff" :height 1.1))))
 '(emms-browser-artist-face ((t (:foreground "#33dd33"))))
 '(emms-browser-composer-face ((t (:foreground "#aaaaff"))))
 '(emms-browser-performer-face ((t (:foreground "#aaaaff"))))
 '(emms-browser-track-face ((t (:foreground "#ee33ee" :height 1.0))))
 '(emms-browser-year/genre-face ((t (:foreground "#aaaaff")))))
