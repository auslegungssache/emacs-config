(setq gc-cons-threshold 100000000)

(setq frame-resize-pixelwise t)
(setq ring-bell-function (lambda ()))
(org-babel-load-file (concat user-emacs-directory "main-config.org"))
(put 'upcase-region 'disabled nil)
