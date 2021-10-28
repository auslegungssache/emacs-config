(when (< emacs-major-version 27)
  (load-file (concat user-emacs-directory "early-init.el")))

(org-babel-load-file (concat user-emacs-directory "main-config.org"))
