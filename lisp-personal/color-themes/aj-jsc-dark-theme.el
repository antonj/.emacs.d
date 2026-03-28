(deftheme aj-jsc-dark
  "Dark variant of the aj-jsc-light theme.")

(setq-default mode-line-buffer-identification
              (list (propertize "%12b" 'face
                                (list :weight 'bold
                                      :foreground "#dddddd"))))

(let (
      (color-bg "#26221f")
      (color-fg "#dcd6ce")
      )

  (custom-theme-set-faces
   'aj-jsc-dark
   `(default ((t ( :foreground ,color-fg :background ,color-bg))))
   `(cursor  ((t (:background "#ff5050"))))

   `(highlight ((t (:background "#2a2a2f"))))
   `(highlight-indentation-face ((t (:inherit highlight))))
   `(highlight-indentation-current-column-face ((t (:background "#333338"))))
   `(fringe ((t (:inherit highlight))))
   `(hl-line-face ((t (:inherit highlight))))
   `(hl-line ((t (:inherit highlight))))

   ;; Swiper
   `(swiper-line-face ((t (:background "#665500"))))

   ;; idle-highlight-in-visible-buffers-mode
   `(idle-highlight-in-visible-buffers ((t (:background "#552244" :underline t))))

   ;; Typography
   `(bold ((t (:bold t))))
   `(bold-italic ((t (:italic t :bold t))))
   `(italic ((t (:italic t))))
   `(underline ((t (:underline t))))

   ;; LSP
   `(lsp-face-highlight-read ((t (:background "#333338"))))
   `(lsp-face-highlight-textual ((t (:background "#554400"))))
   `(lsp-face-highlight-write ((t (:background "#005544"))))
   `(lsp-ui-sideline-code-action((t (:background "#005544"))))

   ;; Error warning
   `(flyspell-incorrect ((t (:inherit default :underline "#ff7755"))))
   `(flyspell-duplicate ((t (:inherit default :underline "#ffaa33"))))

   ;; Font-lock
   `(font-lock-builtin-face ((t (:foreground "#b785c7"))))
   `(font-lock-comment-face ((t (:italic t :bold t :foreground "#6a6a72"))))
   `(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
   `(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :bold t :background "#222224"))))
   `(font-lock-constant-face ((t (:foreground "#7a96bf"))))
   `(font-lock-function-name-face ((t (:bold nil :foreground "#6c96bf"))))
   `(font-lock-keyword-face ((t (:bold t :foreground "#b989d7"))))
   `(font-lock-string-face ((t (:foreground "#7fd487"))))
   `(font-lock-type-face ((t (:foreground "#88aaff"))))
   `(font-lock-variable-name-face ((t (:foreground "#c4a16a"))))
   `(font-lock-warning-face ((t (:foreground "#ff7755"))))

   ;; LaTeX
   `(font-latex-sedate ((t (:inherit font-lock-keyword-face))))
   `(font-latex-string-face ((t (:inherit font-lock-string-face))))

   ;; Comint
   `(comint-highlight-input ((t (:inherit font-lock-keyword-face))))
   `(comint-highlight-prompt ((t (:inherit font-lock-function-name-face))))
   `(compilation-info ((t (:inherit font-lock-function-name-face))))

   ;; DIFF
   `(diff-header ((t (:inherit highlight))))
   `(diff-hunk-header ((t (:inherit diff-header))))
   `(diff-removed ((t (:foreground "#ff5599" :weight bold))))
   `(diff-indicator-removed ((t (:inherit diff-removed))))
   `(diff-added ((t (:foreground "#99dd55" :weight bold))))
   `(diff-indicator-added ((t (:inherit diff-added))))
   `(diff-refine-change ((t (:inherit highlight))))

   ;; Org-mode
   `(org-checkbox ((t (:inherit highlight))))
   `(org-link ((t (:foreground "#66aaff"))))
   `(org-date ((t (:foreground "#bb77ff"))))
   `(org-todo ((t (:foreground "#ff5599" :weight bold))))
   `(org-done ((t (:foreground "#99dd55" :weight bold))))
   `(org-upcoming-deadline ((t (:foreground "#c47a2c" :weight bold))))
   `(org-level-1 ((t (:inherit font-lock-constant-face :height 1.3 :weight bold))))
   `(org-level-2 ((t (:inherit font-lock-keyword-face :height 1.1 :weight bold))))
   `(org-level-3 ((t (:inherit font-lock-variable-name-face :weight bold))))
   `(org-level-4 ((t (:inherit font-lock-comment-face :weight bold))))
   `(markdown-header-face-1 ((t (:inherit font-lock-constant-face :height 1.3 :weight bold))))
   `(markdown-header-face-2 ((t (:inherit font-lock-keyword-face :height 1.1 :weight bold))))
   `(markdown-header-face-3 ((t (:inherit font-lock-variable-name-face :weight bold))))
   `(markdown-header-face-4 ((t (:inherit font-lock-comment-face :weight bold))))

   ;; Mode-line
   `(mode-line ((t (:background "#663366" :foreground "#ffffff"
                                :underline nil
                                :box (:line-width 1 :color "#553355" :style nil)))))
   `(mode-line-inactive ((t (:background "#2a2a2f"
                                         :foreground "#aaaaaa"
                                         :underline nil
                                         :box (:line-width 1 :color "#333338" :style nil)))))

   `(region ((t (:background "#663366"))))

   ;; Remaining faces largely inherited and recolored sensibly toward dark hues
   `(minibuffer-prompt ((t (:foreground "#dddddd"))))
   `(dired-directory ((t (:inherit font-lock-function-name-face))))
   `(dired-header ((t (:inherit font-lock-keyword-face :height 1.2))))
   `(ido-subdir ((t (:inherit font-lock-function-name-face))))
   `(ido-only-match ((t (:inherit font-lock-string-face :weight bold))))
   `(ido-first-match ((t (:inherit font-lock-string-face))))
   `(ido-first-match-face ((t (:inherit font-lock-string-face))))

   `(nxml-element-local-name ((t (:foreground "#66aaff"))))
   `(nxml-tag-delimiter ((t (:inherit nxml-element-local-name))))
   `(nxml-attribute-local-name ((t (:foreground "#88cc44"))))
   `(nxml-attribute-value ((t (:inherit font-lock-string-face))))

   `(show-paren-match-face ((t (:background "#663366"))))
   `(show-paren-mismatch-face ((t (:background "#444466" :foreground "#ffffff"))))

   `(secondary-selection ((t (:background "#224422"))))
   ))

(provide-theme 'aj-jsc-dark)
