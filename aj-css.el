;; CSS
;; Time-stamp: "2012-03-13 17:02:06 antonj"

(defun aj-css-mode-hook()
  (setq css-indent-offset 3)
  ;; C-style indentation
  (setq cssm-indent-function #'cssm-c-style-indenter)
  (autopair-mode -1))
(add-hook 'css-mode-hook 'aj-css-mode-hook)

(setq scss-sass-options '("--style" "compressed"))
(defun aj-scss-mode-hook()
  (setq cssm-indent-function #'cssm-c-style-indenter)
  ;; (setq scss-sass-options '("--style" "compressed"))
  (autopair-mode -1) ;; Does not work with scss :/
  (rainbow-mode t))
(add-hook 'scss-mode-hook 'aj-scss-mode-hook)

(provide 'aj-css)
