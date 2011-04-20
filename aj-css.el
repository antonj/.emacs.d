;; CSS
;; Time-stamp: "2011-04-12 10:51:30 anton"

(defun aj-css-mode-hook()
  (setq css-indent-offset 2)
  ;; C-style indentation
  (setq cssm-indent-function #'cssm-c-style-indenter)
  (flymake-mode t))
(add-hook 'css-mode-hook 'aj-css-mode-hook)

(provide 'aj-css)