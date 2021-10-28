(when (not (boundp 'early-init-file))
  (load-file (concat user-emacs-directory "early-init.el")))

(org-babel-load-file (concat user-emacs-directory "main-config.org"))
