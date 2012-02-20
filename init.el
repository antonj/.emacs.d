;; Anton Johansson
;; Time-stamp: "2012-02-15 12:22:31 antonj"

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

(require 'cl)
(require 'aj-generic)

;; El-get
;; (url-retrieve
;;  "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
;;  (lambda (s)
;;    (end-of-buffer)
;;    (eval-print-last-sexp)))


(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(setq el-get-default-process-sync t)

(setq
 el-get-sources
 '((:name color-theme
          :after (lambda () (require 'aj-color)))
   ;; (:name aj-package-23-compat
   ;;        :type http
   ;;        :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el"
   ;;        :post-init (lambda() (setq package-archives
   ;;                                   '(("ELPA" . "http://tromey.com/elpa/")
   ;;                                     ("gnu" . "http://elpa.gnu.org/packages/")
   ;;                                     ("marmalade" . "http://marmalade-repo.org/packages")))))
   ;; (:name org-mode
   ;;        :after (lambda () (require 'aj-org)))
   ;; (:name emacs-jabber
   ;;        :after (lambda ()
   ;;                 (require 'aj-jabber)))        ;; switch-window
   (:name color-theme-wombat+
          :type http
          :depends color-theme
          :url "http://jaderholm.com/color-themes/color-theme-wombat.el"
          :post-init (lambda ()
                       (autoload 'color-theme-wombat+ "color-theme-wombat"
                         "color-theme: tango" t)))

   ;; (:name hindent-minor-mode
   ;;        :type git
   ;;        :url "git://gist.github.com/1693964.git"
   ;;        :features hindent-minor-mode)
   (:name rcirc-notify
          :type git
          :url "git@github.com:antonj/rcirc-notify-el.git"
          :features rcirc-notify)
   (:name aj-yasnippet
          :type svn
          :url "http://yasnippet.googlecode.com/svn/tags/REL_0_6_1c/"
          :features yasnippet
          :after (lambda ()
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
   ;; (:name anything
   ;;        :after (lambda()
   ;;                 (require 'aj-anything)
   ;;                 (require 'anything-config)))
   (:name multi-term
          :after (lambda() (require 'aj-term)))

   (:name git-emacs
          :type git
          :url "git@github.com:antonj/git-emacs.git"
          :after (lambda()
                   (require 'git-emacs)
                   (require 'git-status)))
   (:name eclim
          :post-init (lambda()
                       ;;(require 'company-emacs-eclim)
                       (require 'aj-eclim)))
   (:name espresso-mode
          :type http
          :url "http://download-mirror.savannah.gnu.org/releases/espresso/espresso.el")
   (:name autopair
          :after (lambda()
                   (autopair-global-mode t)
                   (setq autopair-autowrap t)))
   ;; (:name nxhtml
   ;;        :after (lambda()
   ;;                 (load "~/.emacs.d/el-get/nxhtml/autostart.el")
   ;;                 (setq mumamo-background-colors nil)))
   (:name magit
          :after (lambda ()
                   (message "magit after")
                   (add-hook 'magit-mode-hook
                             (lambda ()
                               (local-set-key "\M-1" 'beginning-of-buffer)
                               (local-set-key "\M-2" 'end-of-buffer)
                               (local-set-key [(c)] 'git-commit)))))
   (:name auctex
          :repo ("ELPA" . "http://tromey.com/elpa/")
          :type elpa
          :post-init (lambda()
                       (add-to-list 'load-path
                                    (expand-file-name (concat el-get-dir "auctex")))))))

(setq
 aj:el-get-packages
 '(el-get
   js2-mode
   ruby-mode
   auto-complete
   psvn
   yaml-mode
   markdown-mode
   ;;php-mode-improved
   coffee-mode
   python-mode
   undo-tree
   rainbow-mode
   highlight-indentation
   scss-mode
   color-theme-solarized
   color-theme-tango
   color-theme-tango-2
   color-theme-zenburn))

(setq aj:el-get-packages
      (append
       aj:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))

;; install new packages and init already installed packages
(el-get 'sync aj:el-get-packages)

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
