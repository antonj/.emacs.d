;;; Color theme based view-source:https://raw.githubusercontent.com/Zyst/Egoist-One/master/themes/Egoist-One.json
(defun aj-color-theme-egoist ()
  "A color theme based on Tango Palette."
  (interactive)
  (color-theme-install
   '(aj-color-theme-tango
     ((background-color . "#2F333D")
      (background-mode . dark)
      (border-color . "#888a85")
      (cursor-color . "#fce94f")
      (foreground-color . "#D7DAE0")
      (mouse-color . "#51B5C2"))

     (border ((t (:background "#888a85"))))
     (fringe ((t (:background "#404446"))))

     (highlight ((t (:background "grey10"))))
     (secondary-selection ((t (:background "grey15"))))

     (mode-line ((t (:background "#eeeeec" :foreground "black" :box nil))))
     (mode-line-inactive ((t (:background "gray55" :foreground "black" :box nil))))
     ;; (mode-line ((t (:foreground "#eeeeec" :background "#555753"))))
     ;; (mode-line-inactive ((t (:background "gray77" :foreground "black" :box nil))))
     (region ((t (:background "#555753"))))
     (font-lock-builtin-face ((t (:foreground "#e5c07b"))))
     (font-lock-comment-face ((t (:foreground "#5c6370"))))
     (font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :bold t))))
     (font-lock-constant-face ((t (:foreground "#51B5C2"))))
     (font-lock-doc-face ((t (:foreground "#5c6370"))))
     (font-lock-keyword-face ((t (:foreground "#e5c07b"))))
     (font-lock-string-face ((t (:foreground "#98c378" :italic t))))
     (font-lock-type-face ((t (:foreground "#51B5C2"))))
     (font-lock-variable-name-face ((t (:foreground "#e06c75"))))
     (font-lock-warning-face ((t (:bold t :foreground "#f57900"))))
     (font-lock-function-name-face ((t (:foreground "#61afef" :italic t))))
     (comint-highlight-input ((t (:italic t :bold t))))
     (comint-highlight-prompt ((t (:foreground "#51B5C2"))))
     (isearch ((t (:background "#f57900" :foreground "#2F333D"))))
     (isearch-lazy-highlight-face ((t (:foreground "#2F333D" :background "#e9b96e"))))
     (show-paren-match-face ((t (:foreground "#2F333D" :background "#73d216"))))
     (show-paren-mismatch-face ((t (:background "#98c378" :foreground "#2F333D"))))
     (minibuffer-prompt ((t (:foreground "#e5c07b" :bold t))))
     (info-xref ((t (:foreground "#e5c07b"))))
     (info-xref-visited ((t (:foreground "#98c378"))))

     ;; Highlight indentation
     (highlight-indentation-face ((t (:background "#404446"))))
     (highlight-indentation-current-column-face ((t (:background "#505556"))))

     ;; JS
     (js2-function-param ((t (:foreground "#e06c75"))))

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

(provide 'aj-color-theme-egoist)
