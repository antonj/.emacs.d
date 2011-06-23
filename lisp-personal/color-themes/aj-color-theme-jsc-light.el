(defun aj-color-theme-jsc-light ()
  "Modified color theme, original by John S Cooper, created 2000-06-08."
  (interactive)
  
  (setq-default mode-line-buffer-identification
                (list (propertize "%12b" 'face
                                  (list :weight 'bold
                                        :foreground "#222222"))))
  
  (color-theme-install
   '(aj-color-theme-jsc-light
     ((background-color . "#eeeedd")
      (background-mode . light)
      (border-color . "black")
      (cursor-color . "Red")
      (foreground-color . "#333344")
      (mouse-color . "black"))
     ((gnus-mouse-face . highlight)
      (list-matching-lines-face . bold)
      (view-highlight-face . highlight))
     (default ((t (nil))))

     ;; AJ modified
     ;; "#07c"
     ;; "#70c"
     ;; "#0c7"
     ;; "#c07"
     ;; "#c70"
     ;; "#7c0"
     (highlight ((t (:background "#e3e3d3"))))
     ;; (highlight-indent-face ((t (:inherit highlight))))
     (fringe ((t (:inherit highlight))))
     
     ;; Typography
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (italic ((t (:italic t))))
     (underline ((t (:underline t))))

     ;; Error warning
     (flyspell-incorrect ((t (:inherit default :underline "OrangeRed"))))
     (flyspell-duplicate ((t (:inherit default :underline "Gold3"))))

     ;; Font-lock
     (font-lock-builtin-face ((t (:foreground "Orchid"))))
     (font-lock-comment-face ((t (:italic t :bold t :foreground "#999988"))))
     (font-lock-doc-face ((t (:inherit font-lock-comment-face))))
     (font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :bold t :background "#ddddcc"))))
     (font-lock-constant-face ((t (:foreground "navy"))))
     (font-lock-function-name-face ((t (:bold t :foreground "Blue"))))
     (font-lock-keyword-face ((t (:bold t :foreground "Purple"))))
     (font-lock-string-face ((t (:foreground "Green4"))))
     (font-lock-type-face ((t (:foreground "Navy"))))
     (font-lock-variable-name-face ((t (:foreground "Tan4"))))
     (font-lock-warning-face ((t (:foreground "OrangeRed"))))

     ;; LaTeX
     (font-latex-sedate ((t (:inherit font-lock-keyword-face))))
     (font-latex-string-face ((t (:inherit font-lock-string-face))))
     
     ;; Org-mode
     (org-link ((t (:foreground "#0077CC" :underline nil))))
     (org-date ((t (:foreground "#7700cc"))))
     (org-todo ((t (:foreground "#cc0077" :weight bold))))
     (org-done ((t (:foreground "#77cc00" :weight bold))))
     (org-upcoming-deadline ((t (:foreground "chocolate" :weight bold))))
     
     (org-level-1 ((t (:inherit font-lock-constant-face
                                :height 1.3
                                :weight bold))))
     (org-level-2 ((t (:inherit font-lock-keyword-face
                                :height 1.1
                                :weight bold))))
     
     (org-level-3 ((t (:inherit font-lock-variable-name-face
                                :weight bold))))

     ;; Jabber
     (jabber-chat-prompt-foreign ((t (:inherit font-lock-constant-face))))
     (jabber-chat-prompt-local ((t (:inherit font-lock-comment-face))))

     ;; mode-line-inactive
     (modeline ((t (:background "plum" :foreground "black" :box nil))))
     (mode-line-inactive ((t (:background "thistle" :foreground "black" :box nil))))
     (modeline-buffer-id ((t (:background "plum" :foreground "black"))))
     (modeline-mousable ((t (:background "plum" :foreground "black"))))
     (modeline-mousable-minor-mode ((t (:background "plum" :foreground "black"))))
     (region ((t (:background "plum"))))
     
     (dired-directory ((t (:inherit font-lock-function-name-face))))
     (dired-header ((t (:inherit font-lock-keyword-face :height 1.2))))
     (ido-subdir ((t (:inherit font-lock-function-name-face))))
     (ido-only-match ((t (:inherit font-lock-string-face :weight bold))))
     (ido-first-match ((t (:inherit font-lock-string-face))))
     (ido-first-match-face ((t (:inherit font-lock-string-face))))
     (minibuffer-prompt ((t (:foreground "black"))))
     (nxml-element-local-name ((t (:foreground "#07C" ))))
     (nxml-tag-delimiter ((t (:inherit nxml-element-local-name))))
     (nxml-attribute-local-name ((t (:foreground "#7C0" ))))
     (nxml-attribute-value ((t (:inherit font-lock-string-face))))

     (woman-bold ((t (:foreground "#07C"))))
     
     ;; Old
     
     (custom-button-face ((t (nil))))
     (custom-changed-face ((t (:background "blue" :foreground "white"))))
     (custom-documentation-face ((t (nil))))
     (custom-face-tag-face ((t (:underline t))))
     (custom-group-tag-face ((t (:underline t :foreground "blue"))))
     (custom-group-tag-face-1 ((t (:underline t :foreground "red"))))
     (custom-invalid-face ((t (:background "red" :foreground "yellow"))))
     (custom-modified-face ((t (:background "blue" :foreground "white"))))
     (custom-rogue-face ((t (:background "black" :foreground "pink"))))
     (custom-saved-face ((t (:underline t))))
     (custom-set-face ((t (:background "white" :foreground "blue"))))
     (custom-state-face ((t (:foreground "dark green"))))
     (custom-variable-button-face ((t (:underline t :bold t))))
     (custom-variable-tag-face ((t (:underline t :foreground "blue"))))
     (gnus-cite-attribution-face ((t (:italic t))))
     (gnus-cite-face-1 ((t (:foreground "MidnightBlue"))))
     (gnus-cite-face-10 ((t (:foreground "medium purple"))))
     (gnus-cite-face-11 ((t (:foreground "turquoise"))))
     (gnus-cite-face-2 ((t (:foreground "firebrick"))))
     (gnus-cite-face-3 ((t (:foreground "dark green"))))
     (gnus-cite-face-4 ((t (:foreground "OrangeRed"))))
     (gnus-cite-face-5 ((t (:foreground "dark khaki"))))
     (gnus-cite-face-6 ((t (:foreground "dark violet"))))
     (gnus-cite-face-7 ((t (:foreground "SteelBlue4"))))
     (gnus-cite-face-8 ((t (:foreground "magenta"))))
     (gnus-cite-face-9 ((t (:foreground "violet"))))
     (gnus-emphasis-bold ((t (:bold t))))
     (gnus-emphasis-bold-italic ((t (:italic t :bold t))))
     (gnus-emphasis-highlight-words ((t (:background "black" :foreground "yellow"))))
     (gnus-emphasis-italic ((t (:italic t))))
     (gnus-emphasis-underline ((t (:underline t))))
     (gnus-emphasis-underline-bold ((t (:underline t :bold t))))
     (gnus-emphasis-underline-bold-italic ((t (:underline t :italic t :bold t))))
     (gnus-emphasis-underline-italic ((t (:underline t :italic t))))
     (gnus-group-mail-1-empty-face ((t (:foreground "DeepPink3"))))
     (gnus-group-mail-1-face ((t (:bold t :foreground "DeepPink3"))))
     (gnus-group-mail-2-empty-face ((t (:foreground "HotPink3"))))
     (gnus-group-mail-2-face ((t (:bold t :foreground "HotPink3"))))
     (gnus-group-mail-3-empty-face ((t (:foreground "magenta4"))))
     (gnus-group-mail-3-face ((t (:bold t :foreground "magenta4"))))
     (gnus-group-mail-low-empty-face ((t (:foreground "DeepPink4"))))
     (gnus-group-mail-low-face ((t (:bold t :foreground "DeepPink4"))))
     (gnus-group-news-1-empty-face ((t (:foreground "blue2"))))
     (gnus-group-news-1-face ((t (:bold t :foreground "blue2"))))
     (gnus-group-news-2-empty-face ((t (:foreground "CadetBlue4"))))
     (gnus-group-news-2-face ((t (:bold t :foreground "CadetBlue4"))))
     (gnus-group-news-3-empty-face ((t (nil))))
     (gnus-group-news-3-face ((t (:bold t))))
     (gnus-group-news-4-empty-face ((t (nil))))
     (gnus-group-news-4-face ((t (:bold t))))
     (gnus-group-news-5-empty-face ((t (nil))))
     (gnus-group-news-5-face ((t (:bold t))))
     (gnus-group-news-6-empty-face ((t (nil))))
     (gnus-group-news-6-face ((t (:bold t))))
     (gnus-group-news-low-empty-face ((t (:foreground "DarkGreen"))))
     (gnus-group-news-low-face ((t (:bold t :foreground "DarkGreen"))))
     (gnus-header-content-face ((t (:italic t :foreground "blue"))))
     (gnus-header-from-face ((t (:foreground "red3"))))
     (gnus-header-name-face ((t (:foreground "red3"))))
     (gnus-header-newsgroups-face ((t (:italic t :foreground "MidnightBlue"))))
     (gnus-header-subject-face ((t (:bold t :foreground "red"))))
     (gnus-signature-face ((t (:foreground "pink"))))
     (gnus-splash-face ((t (:foreground "Brown"))))
     (gnus-summary-cancelled-face ((t (:background "black" :foreground "yellow"))))
     (gnus-summary-high-ancient-face ((t (:bold t :foreground "RoyalBlue"))))
     (gnus-summary-high-read-face ((t (:bold t :foreground "navy"))))
     (gnus-summary-high-ticked-face ((t (:bold t :foreground "firebrick"))))
     (gnus-summary-high-unread-face ((t (:bold t :foreground "blue"))))
     (gnus-summary-low-ancient-face ((t (:italic t :foreground "RoyalBlue"))))
     (gnus-summary-low-read-face ((t (:italic t :foreground "DarkGreen"))))
     (gnus-summary-low-ticked-face ((t (:italic t :foreground "firebrick"))))
     (gnus-summary-low-unread-face ((t (:italic t))))
     (gnus-summary-normal-ancient-face ((t (:foreground "RoyalBlue"))))
     (gnus-summary-normal-read-face ((t (:foreground "red3"))))
     (gnus-summary-normal-ticked-face ((t (:foreground "black"))))
     (gnus-summary-normal-unread-face ((t (:bold t :foreground "red3"))))
     (gnus-summary-selected-face ((t (:underline t))))
     (makefile-space-face ((t (:background "hotpink"))))
     (message-cited-text-face ((t (:foreground "red"))))
     (message-header-cc-face ((t (:foreground "MidnightBlue"))))
     (message-header-name-face ((t (:foreground "cornflower blue"))))
     (message-header-newsgroups-face ((t (:italic t :bold t :foreground "blue4"))))
     (message-header-other-face ((t (:foreground "steel blue"))))
     (message-header-subject-face ((t (:bold t :foreground "navy blue"))))
     (message-header-to-face ((t (:bold t :foreground "MidnightBlue"))))
     (message-header-xheader-face ((t (:foreground "blue"))))
     (message-mml-face ((t (:foreground "ForestGreen"))))
     (message-separator-face ((t (:foreground "brown"))))
     (secondary-selection ((t (:background "palegreen"))))
     (show-paren-match-face ((t (:background "plum"))))
     (show-paren-mismatch-face ((t (:background "navy" :foreground "white"))))
     (speedbar-button-face ((t (:foreground "green4"))))
     (speedbar-directory-face ((t (:foreground "blue4"))))
     (speedbar-file-face ((t (:foreground "cyan4"))))
     (speedbar-highlight-face ((t (:background "green"))))
     (speedbar-selected-face ((t (:underline t :foreground "red"))))
     (speedbar-tag-face ((t (:foreground "brown"))))
     (widget-button-face ((t (:bold t))))
     (widget-button-pressed-face ((t (:foreground "red"))))
     (widget-documentation-face ((t (:foreground "dark green"))))
     (widget-field-face ((t (:background "gray85"))))
     (widget-inactive-face ((t (:foreground "dim gray"))))
     (widget-single-line-field-face ((t (:background "gray85")))))))