;; CSS
;; Time-stamp: "2011-12-08 13:28:05 antonj"

(defun aj-css-mode-hook()
  (setq css-indent-offset 3)
  ;; C-style indentation
  (setq cssm-indent-function #'cssm-c-style-indenter)
  (autopair-mode -1)
  (flymake-mode t))
(add-hook 'css-mode-hook 'aj-css-mode-hook)

(defun aj-scss-mode-hook()
  (setq cssm-indent-function #'cssm-c-style-indenter)
  ;; (setq scss-sass-options '("--style" "compressed"))
  (autopair-mode -1) ;; Does not work with scss :/
  (rainbow-mode t))
(add-hook 'scss-mode-hook 'aj-scss-mode-hook)

(provide 'aj-css)
