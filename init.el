(when (< emacs-major-version 27)
  (load-file (concat user-emacs-directory "early-init.el")))

;; copied from https://web.archive.org/web/20161118135021/http://www.holgerschurig.de/en/emacs-efficiently-untangling-elisp/
(defun my-tangle-section-canceled ()
  "Return t if the current section header was CANCELED, else nil."
  (save-excursion
    (if (re-search-backward "^\\*+\\s-+\\(.*?\\)?\\s-*$" nil t)
        (string-prefix-p "CANCELED" (match-string 1))
      nil)))
(defun my-tangle-config-org (orgfile elfile)
  "This function will write all source blocks from =config.org= into
=config.el= that are ...

- not marked as :tangle no
- have a source-code of =emacs-lisp=
- doesn't have the todo-marker CANCELED"
  (let* ((body-list ())
         (gc-cons-threshold most-positive-fixnum)
         (org-babel-src-block-regexp   (concat
                                        ;; (1) indentation                 (2) lang
                                        "^\\([ \t]*\\)#\\+begin_src[ \t]+\\([^ \f\t\n\r\v]+\\)[ \t]*"
                                        ;; (3) switches
                                        "\\([^\":\n]*\"[^\"\n*]*\"[^\":\n]*\\|[^\":\n]*\\)"
                                        ;; (4) header arguments
                                        "\\([^\n]*\\)\n"
                                        ;; (5) body
                                        "\\([^\000]*?\n\\)??[ \t]*#\\+end_src")))
    (with-temp-buffer
      (insert-file-contents orgfile)
      (goto-char (point-min))
      (while (re-search-forward org-babel-src-block-regexp nil t)
        (let ((lang (match-string 2))
              (args (match-string 4))
              (body (match-string 5))
              (canc (my-tangle-section-canceled)))
          (when (and (string= lang "emacs-lisp")
                     (not (string-match-p ":tangle\\s-+no" args))
                     (not canc))
            (add-to-list 'body-list body)))))
    (with-temp-file elfile
      (insert (format ";; Don't edit this file, edit %s instead ...\n\n" orgfile))
      (apply 'insert (reverse body-list)))
    (message "Wrote %s ..." elfile)))

(defvar my-emacs-config-org (expand-file-name "main-config.org" user-emacs-directory))
(defvar my-emacs-config-el (expand-file-name "var/config.el" user-emacs-directory))
(when (file-newer-than-file-p my-emacs-config-org my-emacs-config-el)
  (my-tangle-config-org my-emacs-config-org my-emacs-config-el))
(load-file my-emacs-config-el)
