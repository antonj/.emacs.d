;; Anton Johansson
;; Time-stamp: "2012-06-26 14:32:50 antonj"

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

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

(setq el-get-default-process-sync t)

(setq
 el-get-sources
 '(el-get
   js2-mode
   ruby-mode
   psvn
   yaml-mode
   coffee-mode
   ;;python-mode
   undo-tree
   highlight-indentation
   scss-mode
   color-theme-solarized
   color-theme-tango
   color-theme-tango-2
   protobuf-mode
   paredit
   ;;php-mode-improved
   ;;color-theme-zenburn
   ;; (:name powerline
   ;;        :type git
   ;;        :features powerline
   ;;        :url "https://github.com/jonathanchu/emacs-powerline.git")
   
   (:name scala-mode
          :after (progn
                   (add-hook 'scala-mode-hook
                             '(lambda()
                                (local-set-key (kbd "C-<tab>") 'other-window)
                                (local-set-key (kbd "C-S-<tab>") (lambda () (interactive) (other-window -1)))
                                (local-set-key "\M-n" 'just-one-space)))))
   (:name ensime
          :load-path ("./dist_2.9.2/elisp")
          :after (progn
                   (define-key ensime-mode-map (kbd "M-g n") 'ensime-forward-note)
                   (define-key ensime-mode-map (kbd "M-g p") 'ensime-backward-note)
                   (define-key ensime-mode-map (kbd "M-n") 'just-one-space)))
   
   (:name highlight-parentheses
          :after (progn
                   (highlight-parentheses-mode)))
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
   (:name aj-yasnippet
          :type svn
          :url "http://yasnippet.googlecode.com/svn/tags/REL_0_6_1c/"
          :features yasnippet
          :after (progn
                   (yas/initialize)
                   (add-to-list 'yas/root-directory (concat el-get-dir "aj-yasnippet/snippets"))
                   (add-to-list 'yas/root-directory  "~/.emacs.d/aj-snippets")

                   ;; Map `yas/load-directory' to every element
                   ;; (mapc 'yas/load-directory yas/root-directory)

                   (setq yas/prompt-functions '(yas/dropdown-prompt
                                                yas/ido-prompt
                                                yas/completing-prompt
                                                yas/x-prompt
                                                yas/no-prompt))

                   ;; (add-to-list 'yas/extra-mode-hooks
                   ;;              'nxml-mode-hook)
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
   (:name eclim
          :post-init (progn
                       ;;(require 'company-emacs-eclim)
                       (require 'aj-eclim)))
   (:name auto-complete)
   (:name ac-slime
          :after (progn
                   (add-hook 'slime-mode-hook 'set-up-slime-ac)))
   (:name clojure-mode
          :after (progn
                   (add-hook 'slime-mode-hook
                             '(lambda ()
                                (local-set-key "\M-n" 'just-one-space)))))

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

(el-get 'sync el-get-packages)

;; Personal
(autoload 'less-mode "less-mode")
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-mode))

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

(require 'aj-magit)
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

(setq custom-file "~/.emacs.d/init-custom.el")
(load custom-file 'noerror)

;; Turn of debug
(setq debug-on-error nil)
;; Start server
(server-start)
(message "loaded init.el")
