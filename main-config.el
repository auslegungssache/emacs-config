(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1)

(add-hook 'before-save-hook 'whitespace-cleanup)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package counsel)
(use-package ivy
  :after counsel
  :config
  (ivy-mode 1)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  )

(use-package evil
  :config
  (evil-mode 1)
  )

(set-default-font "xos4 Terminus 14")

(load-theme 'wombat t)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(blink-cursor-mode 0)

;;(global-hl-line-mode 1)
(column-number-mode 1)
(size-indication-mode 1)

(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(use-package diminish
  )

(setq org-startup-indented t)

(setq dired-auto-revert-buffer t)

(setq-default tab-width 2
              indent-tabs-mode nil)

(electric-pair-mode 1)
(show-paren-mode 1)

(use-package company
  :config
  (add-hook 'prog-mode-hook (lambda () (company-mode 1)))
  )

(use-package go-mode
  :config
  (add-hook 'before-save-hook 'gofmt-before-save)
  )
(use-package company-go
  :after company
  )

(use-package tide
  :init
  (setq typescript-indent-level 2)
  :config
  (add-hook 'typescript-mode-hook (lambda () (tide-mode 1)))
  )

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  )
