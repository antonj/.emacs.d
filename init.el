;; Anton Johansson
;; Time-stamp: "2011-04-20 22:06:29 anton"

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/color-theme-6.6.0"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/org-mode/lisp"))

;; El-get
;; (load-file "~/.emacs.d/lisp/el-get-install.el")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)

(setq el-get-sources
      '(;; cssh
        el-get
        ;; scss-mode
        org-mode
        ;; (:name org-mode
        ;;        :after (require 'aj-org))
        psvn
        yaml-mode
        markdown-mode
        ;; auctex
        php-mode-improved
        js2-mode
        gnuplot-mode
        undo-tree
        rainbow-mode
        ;; (:name emacs-jabber
        ;;        :after (lambda ()
        ;;                 (require 'aj-jabber)))
        color-theme
        color-theme-solarized
        color-theme-tango
        color-theme-tango-2
        color-theme-zenburn
        django-mode
        ;; switch-window
        ;; vkill
        ;; google-maps
        ;; nxhtml
        ;; xcscope
        (:name aj-yasnippet
               :type svn
               :url "http://yasnippet.googlecode.com/svn/tags/REL_0_6_1c/"
               :features "yasnippet"
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
        ;;        :after (lambda() (require 'anything-config)))
        (:name multi-term
               :after (lambda() (require 'aj-term)))
        (:name aj-package
               :type http
               :url "http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/emacs-lisp/package.el"
               :features package
               :post-init (lambda ()
                            (defconst package-subdirectory-regexp
                              "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$"
                              "Regular expression matching the name of a package subdirectory.
The first subexpression is the package name.
The second subexpression is the version string.")
                            (setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                                                     ("gnu" . "http://elpa.gnu.org/packages/")))
                            (package-initialize)))
        (:name git-emacs
               :features git-status)
        (:name espresso-mode
               :type http
               :url "http://download-mirror.savannah.gnu.org/releases/espresso/espresso.el")
        (:name autopair
               :after (lambda()
                        (autopair-global-mode t)
                        (setq autopair-autowrap t)))
        (:name magit
               :after (lambda () (message "magit after")))
        (:name auctex
               :type elpa)
        ))
(el-get)
;; 'sync)

;;;; Auto-install start ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn
  ;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/auto-install.el")
  ;; (require 'auto-install)
  ;; (setq auto-install-directory (expand-file-name "~/.emacs.d/lisp/auto-install/"))
  ;; (add-to-list 'load-path auto-install-directory)

  ;; Personal
  (autoload 'less-mode "less-mode")
  (add-to-list 'auto-mode-alist '("\\.less\\'" . less-mode))

  (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal/scss-mode"))
  (autoload 'scss-mode "scss-mode")
  (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
  ;; (require 'scss-mode)

  (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal/highlight-indentation"))
  (require 'highlight-indentation)

  ;; Modes
  (require 'flymake)

  ;;
  ;;;; Auto-install end ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  )

;;;; ELPA start ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn
  ;;

  ;; OLD package.el
  ;; (auto-install-from-url "http://tromey.com/elpa/package.el")
  ;; NEW Builtin emacs pull from git repo HEAD
  ;;(auto-install-from-url "http://git.savannah.gnu.org/gitweb/?p=emacs.git;a=blob_plain;f=lisp/emacs-lisp/package.el;hb=HEAD")
  ;;(require 'package)
  ;;(package-initialize) ;; TODO: should be done within package.el?
  ;; (defcustom package-enable-at-startup t ...) maybe in emacs24 only?

  ;; Use official emacs 24 repository with ELPA
  ;; (setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
  ;;                          ("gnu" . "http://elpa.gnu.org/packages/")))

  ;;;; Auctex elpa from gnu repo
  ;; (package-install 'auctex)
  ;;;; ELPA end ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  )

;; Anyting
;; (require 'anything-config)
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/magit-1.0.0"))
;; (require 'magit)
;; (require 'git)

;; JDE ;; CEDET needs to be loaded first
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/jde/lisp"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/cedet-1.0pre6/common"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/elib-1.0"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/ecb-2.40"))
;; (require 'aj-cedet)
;; (require 'ecb-autoloads)
;; (require 'jde)
;; (require 'aj-java)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$\\|\\.yaml$" . yaml-mode))

;; Personal customizations
(require 'aj-ibuffer)
(require 'aj-macros)
(require 'aj-generic)
(require 'aj-org)
(require 'aj-elisp)
(require 'aj-ediff)
(require 'aj-color)
(require 'aj-html)
(require 'aj-latex)
(require 'aj-irc)
(require 'aj-octave)
(require 'aj-mac)
(require 'aj-c)
(require 'aj-flymake)
(require 'aj-flymake-c)
(require 'aj-flymake-css)
(require 'aj-flymake-js)
(require 'aj-anything)
(require 'aj-compilation)
(require 'aj-ido)
(require 'aj-js)
(require 'aj-dired)
(require 'aj-python)

;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Other customizations
;; (load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxml-mode/rng-auto.el")
(require 'aj-nxml)
;; (load "~/.emacs.d/lisp/nxhtml/autostart.el")
(setq mumamo-background-colors nil)

(require 'rst)
(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))

;; Auto-complete
;; https://github.com/m2ym/auto-complete.git
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/auto-complete/"))
;; (require 'auto-complete-config)
;; (ac-config-default)

;; Yasnippet
;; http://yasnippet.googlecode.com/files/yasnippet-0.6.1c.tar.bz2
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/yasnippet-0.6.1c/"))
;; (require 'yasnippet)

;; Buffers/files identical names
;; TODO : move
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

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