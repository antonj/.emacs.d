;; Anton Johansson

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d/aj"))

(require 'cl)
(require 'aj-generic)

;; El-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch) (end-of-buffer)
          (eval-print-last-sexp)))))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

;; (setq el-get-default-process-sync t)

(setq
 el-get-sources
 '(el-get
   js2-mode
   json-mode
   git-timemachine
   ;; tern
   ruby-mode
   psvn
   yaml-mode
   coffee-mode
   editorconfig ;; brew install editorconfig
   ;;python-mode
   undo-tree
   color-theme-solarized
   color-theme-tango
   color-theme-tango-2
   project-explorer
   ;; protobuf-mode
   paredit
   ;;php-mode-improved
   ;;color-theme-zenburn
   ;; (:name powerline
   ;;        :type git
   ;;        :features powerline
   ;;        :url "https://github.com/jonathanchu/emacs-powerline.git")
   (:name flycheck :type elpa)
   ;; :after (progn (require 'aj-flycheck))
   (:name flx :after (progn )) ;; Flex matching fuzzy stuff
   (:name projectile :after (progn
                              (projectile-global-mode)
                              ;; (define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
                              ;; (define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
                              (define-key projectile-mode-map (kbd "C-x C-j") 'projectile-find-file)
                              ;; (define-key projectile-mode-map [?\s-g] 'projectile-grep)
                              ))
   (:name highlight-indentation
          :after (progn
                   (setq highlight-indentation-offset 2)))
   
   (:name scala-mode2)
   
   (:name scss-mode :after (progn
                             (setq scss-compile-at-save nil)
                             (setq scss-sass-options ())
                             (defun aj-scss-mode-hook()
                               (setq cssm-indent-function #'cssm-c-style-indenter)
                               ;; (setq scss-sass-options '("--style" "compressed"))
                               (rainbow-mode t))
                             (add-hook 'scss-mode-hook 'aj-scss-mode-hook)))
   
   ;; (:name ensime
   ;;        :load-path ("./dist/elisp")
   ;;        :after (progn
   ;;                 (define-key ensime-mode-map (kbd "M-g n") 'ensime-forward-note)
   ;;                 (define-key ensime-mode-map (kbd "M-g p") 'ensime-backward-note)
   ;;                 (define-key ensime-mode-map (kbd "M-n") 'just-one-space)))
   
   (:name highlight-parentheses
          :after (progn
                   (highlight-parentheses-mode)))
   (:name multiple-cursors
          :after (progn
                   (global-set-key (kbd "C-S-n") 'mc/mark-next-like-this)
                   (global-set-key (kbd "C-S-p") 'mc/mark-previous-like-this)
                   (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
                   (global-set-key (kbd "C-S-c C-S-v") 'mc/mark-all-like-this)))
   (:name color-theme
          :after (progn (require 'aj-color)))
   (:name markdown-mode
          :after (progn (require 'aj-markdown)))
   (:name framemove
          :type http
          :features framemove
          :url "http://www.emacswiki.org/emacs/download/framemove.el"
          :after (progn
                   (windmove-default-keybindings)
                   (setq framemove-hook-into-windmove t)))
   (:name restclient
          :type git
          :features restclient
          :url "https://github.com/pashky/restclient.el.git")
   (:name color-theme-wombat+
          :type http
          :depends color-theme
          :url "http://jaderholm.com/color-themes/color-theme-wombat.el"
          :post-init (progn
                       (autoload 'color-theme-wombat+ "color-theme-wombat"
                         "color-theme: tango" t)))
   (:name slime
          :description "Superior Lisp Interaction Mode for Emacs"
          :type github
          :features slime-autoloads
          :pkgname "nablaone/slime"
          :load-path ("." "contrib")
          :compile (".")
          :post-init (slime-setup))
   (:name rcirc-notify
          :type git
          :url "git@github.com:antonj/rcirc-notify-el.git"
          :features rcirc-notify)
   (:name yasnippet
          :after (progn
                   (setq yas-snippet-dirs '("~/.emacs.d/aj-snippets"))
                   (yas-global-mode 1)

                   ;; Map `yas/load-directory' to every element
                   ;; (mapc 'yas/load-directory yas/root-directory)
                   
                   (setq yas/prompt-functions '(yas/dropdown-prompt
                                                yas/ido-prompt
                                                yas/completing-prompt
                                                yas/x-prompt
                                                yas/no-prompt))

                   ;; (add-to-list 'yas/extra-mode-hooks
                   ;;              'nxml-mode-hook)
                   (define-key yas-minor-mode-map [(tab)] nil)
                   (define-key yas-minor-mode-map (kbd "TAB") nil)

                   (set-variable 'yas/trigger-key "")
                   (add-hook 'yas/after-exit-snippet-hook
                             '(lambda ()
                                (indent-region yas/snippet-beg
                                               yas/snippet-end)))
                   (set-variable 'yas/wrap-around-region nil)
                   (yas/reload-all)))
   (:name multi-term
          :after (progn (require 'aj-term)))
   (:name rainbow-mode
          :description "Displays color names with colored background."
          :type git
          :url "https://github.com/emacsmirror/rainbow-mode.git"
          :features rainbow-mode)
   (:name git-emacs
          :type git
          :url "git@github.com:antonj/git-emacs.git"
          :after (progn
                   (require 'git-emacs)
                   (require 'git-status)))
   (:name color-theme-waher
          :type github
          :depends color-theme
          :pkgname "jasonm23/emacs-waher-theme"
          :prepare (autoload 'color-theme-waher "waher-theme"
                     "color-theme: waher-theme" t))
   
   (:name espresso-mode
          :type http
          :url "http://download-mirror.savannah.gnu.org/releases/espresso/espresso.el")
   ;; (:name autopair
   ;;        :after (progn
   ;;                 (autopair-global-mode t)
   ;;                 (setq autopair-autowrap t)
   ;;                 (message "autopair after")
   ;;                 ;; Fix sldb-mode http://code.google.com/p/autopair/issues/detail?id=32
   ;;                 (add-hook 'sldb-mode-hook
   ;;                           #'(lambda ()
   ;;                               ;; for emacsen < 24
   ;;                               (setq autopair-dont-activate t)
   ;;                               ;; for emacsen >= 24
   ;;                               (autopair-mode -1)))))
   (:name magit
          :after (progn
                   (message "magit after")
                   (require 'aj-magit)))
   ;; (:name eclim
   ;;        :post-init (progn
   ;;                     ;;(require 'company-emacs-eclim)
   ;;                     (require 'aj-eclim)))
   (:name auto-complete)
   (:name ac-slime
          :after (progn
                   (add-hook 'slime-mode-hook 'set-up-slime-ac)))
   (:name clojure-mode
          :after (progn
                   (add-hook 'slime-mode-hook
                             '(lambda ()
                                (local-set-key "\M-n" 'just-one-space)))))
   ;; (:name skewer-mode
   ;;        :repo ("ELPA" . "http://melpa.milkbox.net/packages/")
   ;;        :type elpa)
   ;; (:name emacs-jabber
   ;;        :after (progn
   ;;                 (require 'aj-jabber)))
   ;; (:name anything
   ;;        :after (lambda()
   ;;                 (require 'aj-anything)
   ;;                 (require 'anything-config)))
   ;; (:name nxhtml
   ;;        :after (lambda()
   ;;                 (load "~/.emacs.d/el-get/nxhtml/autostart.el")
   ;;                 (setq mumamo-background-colors nil)))
   ;; (:name auctex
   ;;        :repo ("ELPA" . "http://tromey.com/elpa/")
   ;;        :type elpa
   ;;        :post-init (progn
   ;;                     (add-to-list 'load-path
   ;;                                  (expand-file-name (concat el-get-dir "auctex")))))
   ))

;; install new packages and init already installed packages


(setq el-get-packages
      (mapcar 'el-get-source-name el-get-sources))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(el-get 'sync el-get-packages)

;; Personal
(add-hook 'sws-mode-hook
          '(lambda ()
             (highlight-indentation-mode)
             (highlight-indentation-current-column-mode)))

(autoload 'less-mode "less-mode")
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-mode))

(add-to-list 'auto-mode-alist '("\\.vue\\'" . javascript-mode))

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal/scss-mode"))
;; (autoload 'scss-mode "scss-mode")
;; (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;; (require 'scss-mode)

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal/highlight-indentation"))
;; (require 'highlight-indentation)

;; Modes

;; (require 'rst)
;; (add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))

(require 'flymake)
;; Buffers/files identical names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; JDE ;; CEDET needs to be loaded first
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/jde/lisp"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/cedet-1.0pre6/common"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/elib-1.0"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/ecb-2.40"))
;; (require 'aj-cedet)
;; (require 'ecb-autoloads)
;; (require 'jde)
;; (require 'aj-java)

;; Personal customizations
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))


;; (require 'aj-magit)
(require 'aj-markdown)
(require 'aj-org)
(require 'aj-mac)
(require 'aj-ibuffer)
(require 'aj-macros)
(require 'aj-elisp)
(require 'aj-ediff)
(require 'aj-html)
(require 'aj-latex)
(require 'aj-irc)
(require 'aj-octave)
(require 'aj-c)
(require 'aj-flycheck) ;; Install flycheck, elpa
(require 'aj-flymake)
(require 'aj-flymake-c)
;;(require 'aj-flymake-css)
(require 'aj-flymake-js)
(require 'aj-flymake-java)
(require 'aj-compilation)
(require 'aj-ido)
(require 'aj-js)
(require 'aj-css)
(require 'aj-dired)
(require 'aj-python)
(require 'aj-ruby)

;; Other customizations
;; (load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxml-mode/rng-auto.el")
(require 'aj-nxml)
;; (load "~/.emacs.d/lisp/nxhtml/autostart.el")

;; Default to read-only open files
;; (require 'aj-read-only-keymap-hooks)

;; Insert snippets to bufferts with certain extensions
(add-hook 'find-file-not-found-hooks
          '(lambda ()
             (if (equal (file-name-extension (buffer-file-name)) "java")
                 (progn
                   (java-mode)
                   (insert-java-template)
                   (message "Inserted java template")))

             (if (equal (file-name-extension (buffer-file-name)) "html")
                 (progn
                   (nxml-mode)
                   (insert-html5-template)
                   (message "Inserted xhtml template")))))

(setq custom-file "~/.emacs.d/aj/init-custom.el")
(load custom-file 'noerror)

;; Turn of debug
(setq debug-on-error nil)
;; Start server
(server-start)
(message "loaded init.el")
(provide 'init)
;;; init.el ends here
