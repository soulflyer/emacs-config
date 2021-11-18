;;; iw-auto-insert.el ---                            -*- lexical-binding: t; -*-
;; Copyright (C) 2021  Iain Wood
;; Author: Iain Wood <iain@soulflyer.co.uk>
;;; Commentary:
;;
;;; Code:

(setq-default auto-insert-alist
              '((("\\.\\([Hh]\\|hh\\|hpp\\|hxx\\|h\\+\\+\\)\\'" . "C / C++ header")
                 (replace-regexp-in-string "[^A-Z0-9]" "_"
                                           (string-replace "+" "P"
                                                           (upcase
                                                            (file-name-nondirectory buffer-file-name))))
                 "#ifndef " str n "#define " str "

" _ "

#endif")
                (("\\.\\([Cc]\\|cc\\|cpp\\|cxx\\|c\\+\\+\\)\\'" . "C / C++ program")
                 nil "#include \""
                 (let
                     ((stem
                       (file-name-sans-extension buffer-file-name))
                      ret)
                   (dolist
                       (ext
                        '("H" "h" "hh" "hpp" "hxx" "h++")
                        ret)
                     (when
                         (file-exists-p
                          (concat stem "." ext))
                       (setq ret
                             (file-name-nondirectory
                              (concat stem "." ext))))))
                 & 34 | -10)
                (("[Mm]akefile\\'" . "Makefile")
                 . "makefile.inc")
                (html-mode lambda nil
                           (sgml-tag "html"))
                (plain-tex-mode . "tex-insert.tex")
                (bibtex-mode . "tex-insert.tex")
                (latex-mode "options, RET: " "\\documentclass[" str & 93 | -1 123
                            (read-string "class: ")
                            "}
"
                            ("package, %s: " "\\usepackage["
                             (read-string "options, RET: ")
                             & 93 | -1 123 str "}
")
                            _ "
\\begin{document}
" _ "
\\end{document}")
                (("/bin/.*[^/]\\'" . "Shell-Script mode magic number")
                 lambda nil
                 (if
                     (eq major-mode
                         (default-value 'major-mode))
                     (sh-mode)))
                (ada-mode . ada-header)
                (("\\.[1-9]\\'" . "Man page skeleton")
                 "Short description: " ".\\\" Copyright (C), "
                 (format-time-string "%Y")
                 "  "
                 (getenv "ORGANIZATION")
                 |
                 (progn user-full-name)
                 "
.\\\" You may distribute this file under the terms of the GNU Free
.\\\" Documentation License.
.TH "
                 (file-name-base
                  (buffer-file-name))
                 " "
                 (file-name-extension
                  (buffer-file-name))
                 " "
                 (format-time-string "%Y-%m-%d ")
                 "
.SH NAME
"
                 (file-name-base
                  (buffer-file-name))
                 " \\- " str "
.SH SYNOPSIS
.B "
                 (file-name-base
                  (buffer-file-name))
                 "
" _ "
.SH DESCRIPTION
.SH OPTIONS
.SH FILES
.SH \"SEE ALSO\"
.SH BUGS
.SH AUTHOR
"
                 (user-full-name)
                 '(if
                      (search-backward "&"
                                       (line-beginning-position)
                                       t)
                      (replace-match
                       (capitalize
                        (user-login-name))
                       t t))
                 '(end-of-line 1)
                 " <"
                 (progn user-mail-address)
                 ">
")
                (".dir-locals.el" nil ";;; Directory Local Variables
" ";;; For more information see (info \"(emacs) Directory Variables\")

" "(("
'(setq v1
       (let
           (modes)
         (mapatoms
          (lambda
            (mode)
            (let
                ((name
                  (symbol-name mode)))
              (when
                  (string-match "-mode$" name)
                (push name modes)))))
         (sort modes 'string<)))
(completing-read "Local variables for mode: " v1 nil t)
" . (("
(let
    ((all-variables
      (apropos-internal ".*"
                        (lambda
                          (symbol)
                          (and
                           (boundp symbol)
                           (get symbol 'variable-documentation))))))
  (completing-read "Variable to set: " all-variables))
" . "
(completing-read "Value to set it to: " nil)
"))))
")
                (("\\.el\\'" . "Emacs Lisp header")
                 "Short description: " ";;; "
                 (file-name-nondirectory
                  (buffer-file-name))
                 " --- " str
                 (make-string
                  (max 2
                       (- 80
                          (current-column)
                          27))
                  32)
                 "-*- lexical-binding: t; -*-"
                 '(setq lexical-binding t)
                 "
;; Copyright (C) "
                 (format-time-string "%Y")
                 "  "
                 (getenv "ORGANIZATION")
                 |
                 (progn user-full-name)
                 "
;; Author: "
                 (user-full-name)
                 '(if
                      (search-backward "&"
                                       (line-beginning-position)
                                       t)
                      (replace-match
                       (capitalize
                        (user-login-name))
                       t t))
                 '(end-of-line 1)
                 " <"
                 (progn user-mail-address)
                 ">" "
;;; Commentary:
;;
;;; Code:

" _ "

(provide '"
                 (file-name-base
                  (buffer-file-name))
                 ")
;;; "
                 (file-name-nondirectory
                  (buffer-file-name))
                 " ends here
")
                (("\\.texi\\(nfo\\)?\\'" . "Texinfo file skeleton")
                 "Title: " "\\input texinfo   @c -*-texinfo-*-
@c %**start of header
@setfilename "
                 (file-name-base
                  (buffer-file-name))
                 ".info
" "@settitle " str "
@c %**end of header
@copying
"
                 (setq short-description
                       (read-string "Short description: "))
                 ".

" "Copyright @copyright{} "
                 (format-time-string "%Y")
                 "  "
                 (getenv "ORGANIZATION")
                 |
                 (progn user-full-name)
                 "

@quotation
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled ``GNU
Free Documentation License''.

A copy of the license is also available from the Free Software
Foundation Web site at @url{https://www.gnu.org/licenses/fdl.html}.

@end quotation

The document was typeset with
@uref{https://www.gnu.org/software/texinfo/, GNU Texinfo}.

@end copying

@titlepage
@title " str "
@subtitle " short-description "
@author "
                 (getenv "ORGANIZATION")
                 |
                 (progn user-full-name)
                 " <"
                 (progn user-mail-address)
                 ">
@page
@vskip 0pt plus 1filll
@insertcopying
@end titlepage

@c Output the table of the contents at the beginning.
@contents

@ifnottex
@node Top
@top " str "

@insertcopying
@end ifnottex

@c Generate the nodes for this menu with `C-c C-u C-m'.
@menu
@end menu

@c Update all node entries with `C-c C-u C-n'.
@c Insert new nodes with `C-c C-c n'.
@node Chapter One
@chapter Chapter One

" _ "

@node Copying This Manual
@appendix Copying This Manual

@menu
* GNU Free Documentation License::  License for copying this manual.
@end menu

@c Get fdl.texi from https://www.gnu.org/licenses/fdl.html
@include fdl.texi

@node Index
@unnumbered Index

@printindex cp

@bye
")))

(provide 'iw-auto-insert)
;;; iw-auto-insert.el ends here
