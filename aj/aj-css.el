;; CSS
;; Time-stamp: "2025-09-26 19:20:28 antonj"

(defun aj-css-mode-hook()
  (setq css-indent-offset 2)
  (biomejs-format-mode t)
  ;; C-style indentation
  (setq cssm-indent-function #'cssm-c-style-indenter))
(add-hook 'css-mode-hook 'aj-css-mode-hook)

(setq scss-sass-options '("--style" "compressed"))
(set-variable 'scss-compile-at-save nil)

(defun aj-scss-mode-hook()
  (setq cssm-indent-function #'cssm-c-style-indenter)
  ;; (setq scss-sass-options '("--style" "compressed"))
  (biomejs-format-mode t)
  (rainbow-mode t))
(add-hook 'scss-mode-hook 'aj-scss-mode-hook)

(provide 'aj-css)
