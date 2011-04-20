;; Color and style
;; Time-stamp: "2011-04-20 13:02:24 anton"

(defun aj-font-mono ()
  (interactive)
  ;; (set-frame-font "-apple-monaco-medium-r-normal--12-0-72-72-m-0-iso10646-1" nil)
  ;;(set-frame-font "-apple-menlo-medium-r-normal--12-0-72-72-m-0-iso10646-1")
  ;;(set-frame-font "-apple-bitstream vera sans mono-medium-r-normal--11-0-72-72-m-0-iso10646-1" nil)
  (set-frame-font "-apple-InconsolataDZ-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1" nil))

(defun aj-font-serif ()
  (interactive)
  ;; (set-frame-font "-apple-adobe caslon pro-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  ;; (set-frame-font "-apple-baskerville-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  ;; (set-frame-font "-apple-baskerville-medium-r-normal--16-0-72-72-m-0-iso10646-1" nil)
  ;; (set-frame-font "-apple-Minion_Pro-medium-normal-normal-*-18-*-*-*-p-0-iso10646-1" nil)
  (set-frame-font "-apple-Georgia-medium-normal-normal-*-16-*-*-*-p-0-iso10646-1" nil))

(when window-system
  (global-hl-line-mode t)
  (setq indicate-empty-lines t)
  ;; (require 'color-theme)
  ;; (color-theme-initialize)
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/color-themes"))
  (load "~/.emacs.d/lisp-personal/color-themes/aj-color-theme-jsc-light.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-cl-frame.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-rlx.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-inkport.el")
  (load "~/.emacs.d/lisp/color-themes/color-theme-wombat.el")
  ;; https://github.com/sellout/solarized/raw/master/emacs-color-theme-solarized/color-theme-solarized.el
  ;; (load "~/.emacs.d/lisp/color-themes/color-theme-solarized.el")
  ;; (autoload 'zenburn "zenburn" "Color-theme-zenburn." t)
  
  (aj-font-mono)
  (aj-color-theme-jsc-light)
  
  ;;(color-theme-charcoal-black) ;; grey and blue low sat
  ;; (zenburn)
  ;; (face-spec-reset-face 'highlight)
  ;; (set-face-background 'highlight "grey17")
  ;;(set-face-background 'cursor "red"))
  ;;  (progn (color-theme-rlx) ;;dark and fine
  ;;         (set-face-background 'highlight "black"))
  )
  
(defun aj-color-org-levels()
  (interactive)
  (let ((i 0)
        (faces (list
                font-lock-type-face
                font-lock-constant-face
                font-lock-string-face
                font-lock-builtin-face
                font-lock-function-name-face
                font-lock-keyword-face
                font-lock-comment-delimiter-face
                )))
    (dolist (level org-level-faces)
      (set-face-foreground level (face-foreground (nth i faces)))
      (setq i (% (+ i 1) (length faces)))
      )))

(defun aj-code-mode()
  (interactive)
  (aj-font-mono)
  (color-theme-wombat)
  (setq truncate-lines t)
  (set-face-background 'highlight "#000"))

(defun aj-code-mode-light()
  (interactive)
  (aj-font-mono)
  (setq truncate-lines t)
  (aj-color-theme-jsc-light)
  (setq-default mode-line-buffer-identification
              (list (propertize "%12b" 'face
                                (list :weight 'bold
                                      :foreground "Orchid")))))

(defun aj-text-mode()
  (interactive)
  (aj-font-serif)
  ;; (set-face-background 'highlight "grey88")
  (progn (color-theme-jsc-light2) ;;dark and fine
         (face-spec-reset-face 'highlight)
         (set-face-background 'highlight "grey93"))
  
  (custom-set-faces
   '(minibuffer-prompt ((t (:foreground "black"))))
   '(dired-directory ((t (:inherit font-lock-function-name-face))))
   '(ido-subdir ((t (:inherit font-lock-function-name-face))))
   '(ido-only-match ((t (:inherit font-lock-string-face :weight bold))))
   '(ido-first-match ((t (:inherit font-lock-string-face))))
   '(ido-first-match-face ((t (:inherit font-lock-string-face))))
   '(flymake-warnline ((((class color)) (:underline "yellow"))))
   '(flyspell-duplicate ((t (:underline "Gold3"))))
   '(flyspell-incorrect ((t (:underline "OrangeRed"))))))

;; http://xahlee.org/emacs/emacs_make_modern.html
(defun toggle-line-spacing ()
"Toggle line spacing between no extra space to extra half line height."
(interactive)
(if (eq line-spacing nil)
    (setq-default line-spacing 0.2) ; add 0.5 height between lines
  (setq-default line-spacing nil)   ; no extra heigh between lines
  ))
(global-set-key (kbd "<f7>") 'toggle-line-spacing)

;; From http://sachachua.com/wp/2006/09/15/emacs-changingn-the-font-size-on-the-fly/
(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default nil :height (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default nil :height (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)


;; From http://www.emacswiki.org/emacs/HexColour
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{3,6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background 
                                       (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil hexcolour-keywords))

(provide 'aj-color)