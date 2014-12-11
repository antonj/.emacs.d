;; CSS
;; Time-stamp: "2013-08-16 13:10:46 antonj"

(defun aj-css-mode-hook()
  (setq css-indent-offset 3)
  ;; C-style indentation
  (setq cssm-indent-function #'cssm-c-style-indenter))
(add-hook 'css-mode-hook 'aj-css-mode-hook)

(setq scss-sass-options '("--style" "compressed"))
(set-variable 'scss-compile-at-save nil)

(defun aj-scss-mode-hook()
  (setq cssm-indent-function #'cssm-c-style-indenter)
  ;; (setq scss-sass-options '("--style" "compressed"))
  (rainbow-mode t))
(add-hook 'scss-mode-hook 'aj-scss-mode-hook)

(provide 'aj-css)
