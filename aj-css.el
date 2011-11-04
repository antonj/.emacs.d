;; CSS
;; Time-stamp: "2011-10-31 11:18:00 antonj"

(defun aj-css-mode-hook()
  (setq css-indent-offset 2)
  ;; C-style indentation
  (setq cssm-indent-function #'cssm-c-style-indenter)
  (autopair-mode -1)
  (flymake-mode t))
(add-hook 'css-mode-hook 'aj-css-mode-hook)

(provide 'aj-css)
