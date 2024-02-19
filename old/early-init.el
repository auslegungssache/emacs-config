(setq gc-cons-threshold most-positive-fixnum)

(if (and (fboundp 'native-comp-available-p)
         (native-comp-available-p))
    (progn
      (message "Native compilation is available")
      (setq comp-deferred-compilation t
            native-comp-async-report-warnings-errors nil))
  (message "Native complation is *not* available"))
(if (functionp 'json-serialize)
    (message "Native JSON is available")
  (message "Native JSON is *not* available"))

(set-language-environment "utf-8")

;; Make emacs more minimalist
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(blink-cursor-mode 0)

(setq frame-resize-pixelwise t)
