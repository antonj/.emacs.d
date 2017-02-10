;;; Color theme based on Tango Palette. Created by danranx@gmail.com
(defun aj-color-theme-tango ()
  "A color theme based on Tango Palette."
  (interactive)
  (color-theme-install
   '(aj-color-theme-tango
     ((background-color . "#2e3436")
      (background-mode . dark)
      (border-color . "#888a85")
      (cursor-color . "#fce94f")
      (foreground-color . "#ccccca")
      (mouse-color . "#8ae234"))

     (border ((t (:background "#888a85"))))
     (fringe ((t (:background "#404446"))))

     (highlight ((t (:background "grey10"))))
     (secondary-selection ((t (:background "grey15"))))

     (mode-line ((t (:background "#eeeeec" :foreground "black" :box nil))))
     (mode-line-inactive ((t (:background "gray55" :foreground "black" :box nil))))
     ;; (mode-line ((t (:foreground "#eeeeec" :background "#555753"))))
     ;; (mode-line-inactive ((t (:background "gray77" :foreground "black" :box nil))))
     (region ((t (:background "#555753"))))
     (font-lock-builtin-face ((t (:foreground "#729fcf"))))
     (font-lock-comment-face ((t (:foreground "#888a85"))))
     (font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :bold t))))
     (font-lock-constant-face ((t (:foreground "#8ae234"))))
     (font-lock-doc-face ((t (:foreground "#888a85"))))
     (font-lock-keyword-face ((t (:foreground "#729fcf" :bold t))))
     (font-lock-string-face ((t (:foreground "#ad7fa8" :italic t))))
     (font-lock-type-face ((t (:foreground "#8ae234" :bold t))))
     (font-lock-variable-name-face ((t (:foreground "#e9b96e"))))
     (font-lock-warning-face ((t (:bold t :foreground "#f57900"))))
     (font-lock-function-name-face ((t (:foreground "#edd400" :bold t :italic t))))
     (comint-highlight-input ((t (:italic t :bold t))))
     (comint-highlight-prompt ((t (:foreground "#8ae234"))))
     (isearch ((t (:background "#f57900" :foreground "#2e3436"))))
     (isearch-lazy-highlight-face ((t (:foreground "#2e3436" :background "#e9b96e"))))
     (show-paren-match-face ((t (:foreground "#2e3436" :background "#73d216"))))
     (show-paren-mismatch-face ((t (:background "#ad7fa8" :foreground "#2e3436"))))
     (minibuffer-prompt ((t (:foreground "#729fcf" :bold t))))
     (info-xref ((t (:foreground "#729fcf"))))
     (info-xref-visited ((t (:foreground "#ad7fa8"))))

     ;; Highlight indentation
     (highlight-indentation-face ((t (:background "#404446"))))
     (highlight-indentation-current-column-face ((t (:background "#505556"))))

     ;; Speedbar
     (speedbar-button-face ((t (:foreground "green4"))))
     (speedbar-directory-face ((t (:inherit font-lock-function-name-face))))
     (speedbar-file-face ((t (:foreground "cyan4"))))
     (speedbar-highlight-face ((t (:background "#333333"))))
     (speedbar-selected-face ((t (:inherit font-lock-keyword-face))))
     (speedbar-tag-face ((t (:foreground "brown"))))

     (help-highlight-face ((t (:inherit underline))))
     (ibuffer-dired-buffer-face ((t (:inherit font-lock-function-name-face))))
     (ibuffer-help-buffer-face ((t (:inherit font-lock-comment-face))))
     (ibuffer-hidden-buffer-face ((t (:inherit font-lock-warning-face))))
     (ibuffer-occur-match-face ((t (:inherit font-lock-warning-face))))
     (ibuffer-read-only-buffer-face ((t (:inherit font-lock-type-face))))
     (ibuffer-special-buffer-face ((t (:inherit font-lock-keyword-face))))
     (ibuffer-title-face ((t (:inherit font-lock-type-face))))
     )))

(provide 'aj-color-theme-tango)
