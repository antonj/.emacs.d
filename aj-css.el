;; CSS
;; Time-stamp: "2012-05-15 10:44:37 antonj"

(defun aj-css-mode-hook()
  (setq css-indent-offset 3)
  ;; C-style indentation
  (setq cssm-indent-function #'cssm-c-style-indenter))
(add-hook 'css-mode-hook 'aj-css-mode-hook)

(setq scss-sass-options '("--style" "compressed"))
(defun aj-scss-mode-hook()
  (setq cssm-indent-function #'cssm-c-style-indenter)
  ;; (setq scss-sass-options '("--style" "compressed"))
  (rainbow-mode t))
(add-hook 'scss-mode-hook 'aj-scss-mode-hook)

(provide 'aj-css)
