;;; package --- hej

;;; Commentary: grejsneo

;;; Code:

(add-to-list 'load-path (expand-file-name "~/.emacs.d/aj"))


(setenv "GOPATH" "/Users/antonj/Documents/department-http/telness/backend:/Users/antonj/go")


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(require 'cl)
(require 'aj-generic)

;; El-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


(setq
 el-get-sources
 '(el-get
   (:name git-timemachine :type elpa)
   (:name json-mode :type elpa)
   (:name yaml-mode :type elpa)
   (:name go-eldoc :type elpa)
   (:name flow-jsx
          :type git
          :url "https://gitlab.com/rudolfo/emacs-flow-jsx.git"
          :prepare (autoload 'flow-jsx-mode "emacs-flow-jsx-mode.el"))
   (:name go-autocomplete
          :type elpa
          :after (progn
                   (with-eval-after-load 'go-mode
                     (require 'go-autocomplete))))
   (:name go-mode
          :type elpa
          :after (progn
                   (defun aj-go-mode-hook ()
                     (auto-complete-mode 1)
                     (setq gofmt-command "goimports")
                     (go-eldoc-setup)
                     (subword-mode t)
                     ;; (setq compile-command "go build -v && go test -v && go vet && golint")
                     (local-set-key (kbd "M-.") 'godef-jump)
                     (local-set-key (kbd "M-,") 'pop-tag-mark)
                     ;; (setq 'ac-sources '('ac-source-go))
                     (add-hook 'before-save-hook 'gofmt-before-save))
                   (add-hook 'go-mode-hook 'aj-go-mode-hook)))
   (:name ag ;;  brew install the_silver_searcher
          :type elpa)
   (:name wgrep-ag
          :type elpa
          :after (progn
                   (setq wgrep-enable-key (kbd "C-x C-q"))
                   (defun aj-wgrep-setup ()
                     (define-key wgrep-mode-map (kbd "C-c C-q") 'wgrep-abort-changes))
                   (setq wgrep-setup-hook 'aj-wgrep-setup)
                   ))
   (:name prettier-js
          :type elpa
          :after (progn
                   ;; (require 'prettier-js)

                   ;; (setq prettier-command "PATH=$(npm bin):$PATH prettier")
                   ;; (setq prettier-command "prettier")
                   (defun prettier-before-save-on ()
                     (interactive)
                     (setq prettier-target-mode major-mode)
                     (add-hook 'before-save-hook 'prettier-before-save))
                   (defun prettier-before-save-off ()
                     (interactive)
                     (remove-hook 'before-save-hook 'prettier-before-save))))
   (:name js2-mode :type elpa)
   (:name lsp-javascript-typescript
          :type elpa
          :after (progn
                   ;; (add-hook 'rjsx-mode #'lsp-javascript-typescript-enable)
                   ))
   (:name rjsx-mode :type elpa
          :after (progn
                   (defun aj-rjsx-mode-hook ()
                     (subword-mode t)
                     (prettier-js-mode t)
                     (auto-complete-mode -1)
                     (eldoc-mode -1)
                     (flycheck-mode t)

                     (define-key rjsx-mode-map "<" nil)
                     (define-key rjsx-mode-map (kbd "C-d") nil)
                     (define-key rjsx-mode-map (kbd "TAB")
                       '(lambda ()
                          (interactive "*")
                          (indent-for-tab-command)
                          (when (zerop (current-column))
                            (indent-relative))))
                     (define-key rjsx-mode-map (kbd "C-j")
                       '(lambda ()
                          (interactive "*")
                          (electric-newline-and-maybe-indent)
                          (when (zerop (current-column))
                            (indent-relative)))))
                   (add-hook 'rjsx-mode-hook 'aj-rjsx-mode-hook)))
   (:name lsp-mode :type elpa)
   (:name lsp-javascript-typescript :type elpa)
   (:name tern :type elpa) ;; npm i -g ternjs
   (:name editorconfig ;; brew install editorconfig
          :type elpa
          :after (progn
                   (editorconfig-mode 1)))
   (:name graphql-mode
          :type elpa
          :after (progn
                   (add-to-list 'auto-mode-alist '("\\.gql\\'" . graphql-mode))
                   (defun aj-graphql-mode-hook ()
                     (subword-mode t))
                   (add-hook 'graphql-mode-hook 'aj-graphql-mode-hook)))
   (:name protobuf-mode
          :type elpa
          :after (progn
                   (defun aj-protobuf-mode-hook ()
                     (subword-mode t))
                   (add-hook 'protobuf-mode-hook 'aj-protobuf-mode-hook)))
   (:name neotree
          :type elpa
          :after (progn
                   (defun neotree-project-dir ()
                     "Open NeoTree using the git root."
                     (interactive)
                     (set-variable 'neo-window-width 35)

                     (if (and (boundp 'neo-global--window) (eq neo-global--window (selected-window)))
                         (progn
                           (select-window neo-global--window-previous-antonj))
                       (progn
                         (setq neo-global--window-previous-antonj (selected-window))
                         (let ((project-dir (projectile-project-root))
                               (file-name (buffer-file-name)))

                           (neotree)
                           (if project-dir
                               (if (neo-global--window-exists-p)
                                   (progn
                                     (neotree-dir project-dir)
                                     (message "goto %s" file-name)
                                     (neotree-find file-name))
                                 (message "Could not find git project root.")))))))


                   (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
                   (eval-after-load "neotree"
                     '(progn
                       (define-key neotree-mode-map "\M-s" 'neotree-project-dir)
                       (define-key neotree-mode-map (kbd "C-M-p") 'neotree-select-up-node)
                       (define-key neotree-mode-map (kbd "C-M-n") 'neotree-select-next-sibling-node)))

                   (defun aj-neotree-mode-hook ()
                     (highlight-indentation-mode t))
                   (add-hook 'neotree-mode-hook 'aj-neotree-mode-hook)

                   (with-eval-after-load 'neotree
                     (progn
                       (add-to-list 'neo-hidden-regexp-list "^node_modules")
                       (add-to-list 'neo-hidden-regexp-list "[.]test$")
                       ))
                   (setq neo-smart-open t)
                   (setq neo-toggle-window-keep-p nil)

                   ))
   (:name all-the-icons :type elpa)
   (:name undo-tree :type elpa)
   (:name color-theme-solarized :type elpa)
   ;; (:name project-explorer
   ;;        :after (progn
   ;;                 (setq pe/width 25)
   ;;                 (setq pe/omit-regex "^.next\\|^.cache\\|^.DS_Store\\|^#\\|~$\\|^node_modules$\\|[.]pb[.]go$")
   ;;                 (defun aj-project-explorer-mode-hook() (sticky-buffer-window))
   ;;                 (add-hook 'project-explorer-mode-hook 'aj-project-explorer-mode-hook)
   ;;        (define-key project-explorer-mode-map "\M-s" 'previous-multiframe-window)))
   (:name paredit :type elpa)
   (:name slim-mode :type elpa
          :after (progn
                   (defun aj-slim-mode-hook()
                     (highlight-indentation-mode)
                     (highlight-indentation-current-column-mode))
                   (add-hook 'slim-mode-hook 'aj-slim-mode-hook)))
   (:name seq :type elpa)
   (:name drag-stuff :type elpa
          :after (progn
                   (drag-stuff-global-mode 1)

                   (defun shift-text (distance)
                     (if (use-region-p)
                         (let ((mark (mark)))
                           (save-excursion
                             (indent-rigidly (region-beginning)
                                             (region-end)
                                             distance)
                             (push-mark mark t t)
                             (setq deactivate-mark nil)))
                       (indent-rigidly (line-beginning-position)
                                       (line-end-position)
                                       distance)))

                   (defun shift-right (count)
                     (interactive "p")
                     (shift-text count))

                   (defun shift-left (count)
                     (interactive "p")
                     (shift-text (- count)))

                   (define-key drag-stuff-mode-map (drag-stuff--kbd 'up) 'drag-stuff-up)
                   (define-key drag-stuff-mode-map (drag-stuff--kbd 'down) 'drag-stuff-down)
                   (define-key drag-stuff-mode-map (drag-stuff--kbd 'left) 'shift-left)
                   (define-key drag-stuff-mode-map (drag-stuff--kbd 'right) 'shift-right)
                   ))
   (:name flycheck :type elpa
          :after (progn
                   (require 'aj-flycheck) ;; Install flycheck, elpa
                   ))
   (:name flycheck-flow :type elpa)
   (:name web-mode :type elpa
          :after (progn (require 'aj-web)))
   (:name flx :type elpa) ;; Flex matching fuzzy stuff
   (:name flx-ido :type elpa) ;; Flex matching fuzzy stuff
   (:name projectile
          :type elpa
          :after (progn
                   (projectile-global-mode)
                   ;; (define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
                   ;; (define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
                   (define-key projectile-mode-map (kbd "C-x C-j") 'projectile-find-file)
                   ;; (define-key projectile-mode-map [?\s-g] 'projectile-grep)
                   ))
   (:name highlight-indentation
          :type elpa
          :after (progn
                   (setq highlight-indentation-offset 2)))
   (:name scss-mode
          :type elpa
          :after (progn
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
          :type elpa
          :after (progn
                   (highlight-parentheses-mode)))
   (:name multiple-cursors
          :type elpa
          :after (progn
                   (global-set-key (kbd "C-S-n") 'mc/mark-next-like-this)
                   (global-set-key (kbd "C-S-p") 'mc/mark-previous-like-this)
                   (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
                   (global-set-key (kbd "C-S-c C-S-v") 'mc/mark-all-like-this)))
   (:name markdown-mode
          :type elpa
          :after (progn (require 'aj-markdown)))
   (:name framemove
          :type elpa
          :after (progn
                   (windmove-default-keybindings)
                   (setq framemove-hook-into-windmove t)))
   ;; (:name restclient
   ;;        :type git
   ;;        :features restclient
   ;;        :url "https://github.com/pashky/restclient.el.git")
   (:name jade-mode
          :type elpa
          :after (progn
                   (defun aj-jade-mode-hook ()
                     (highlight-indentation-mode)
                     (highlight-indentation-current-column-mode))
                   (add-hook 'jade-mode-hook 'aj-jade-mode-hook)))
   ;; (:name color-theme-wombat+
   ;;        :type http
   ;;        :depends color-theme
   ;;        :url "http://jaderholm.com/color-themes/color-theme-wombat.el"
   ;;        :post-init (progn
   ;;                     (autoload 'color-theme-wombat+ "color-theme-wombat"
   ;;                       "color-theme: tango" t)))
   ;; (:name slime
   ;;        :description "Superior Lisp Interaction Mode for Emacs"
   ;;        :type github
   ;;        :features slime-autoloads
   ;;        :pkgname "nablaone/slime"
   ;;        :load-path ("." "contrib")
   ;;        :compile (".")
   ;;        :post-init (slime-setup))
   (:name rcirc-notify
          :type git
          :url "https://github.com/antonj/rcirc-notify-el.git"
          :features rcirc-notify)
   (:name yasnippet
          :type elpa
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
          :type elpa
          :after (progn
                   (eval-after-load "mutli-term" '(require 'aj-term))))
   (:name rainbow-mode
          :description "Displays color names with colored background."
          :type elpa)
   (:name git-emacs
          :type git
          :url "https://github.com/tsgates/git-emacs.git"
          :after (progn
                   (require 'git-emacs)
                   (require 'git-status)))

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
          :type elpa
          :after (progn
                   (message "magit after")
                   (require 'aj-magit)))
   (:name ido-vertical-mode
          :type elpa
          :after (progn
                   (ido-mode 1)
                   (ido-vertical-mode 1)
                   (setq ido-vertical-define-keys 'C-n-and-C-p-only)))
   (:name ido-completing-read+
          :type elpa
          :after (progn (ido-ubiquitous-mode 1)))
   ;; (:name eclim
   ;;        :post-init (progn
   ;;                     ;;(require 'company-emacs-eclim)
   ;;                     (require 'aj-eclim)))

   ;; (:name company-mode
   ;;        :type elpa)
   ;; (:name
   ;;  company-flow
   ;;  :type elpa
   ;;  :after
   ;;  (progn
   ;;    (add-to-list 'company-backends 'company-flow)
   ;;    ))
   ;; (:name
   ;;  company-tern
   ;;  :type elpa
   ;;  :after (progn
   ;;           (add-to-list 'company-backends 'company-tern)
   ;;           ))
   (:name auto-complete
          :type elpa
          :after (progn
                   (eval-after-load "auto-complete" 
                     '(progn
                       (define-key ac-complete-mode-map "\C-n" 'ac-next)
                       (define-key ac-complete-mode-map "\C-p" 'ac-previous)
                       (define-key ac-complete-mode-map "\r" 'ac-expand)
                       (define-key ac-menu-map "\r" 'ac-expand)))))
          
   ;; (:name ac-slime
   ;;        :after (progn
   ;;                 (add-hook 'slime-mode-hook 'set-up-slime-ac)))
   ;; (:name clojure-mode
   ;;        :after (progn
   ;;                 (add-hook 'slime-mode-hook
   ;;                           '(lambda ()
   ;;                              (local-set-key "\M-n" 'just-one-space)))))
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

;;;; Flowtype autocomplete
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal/auto-complete-flowtype"))
;; (require 'auto-complete-flowtype)

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
(require 'aj-color)
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
(require 'aj-ruby)

;; Other customizations
;; (load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxml-mode/rng-auto.el")
(require 'aj-nxml)
;; (load "~/.emacs.d/lisp/nxhtml/autostart.el")

;; Default to read-only open files
;; (require 'aj-read-only-keymap-hooks)

;; Insert snippets to bufferts with certain extensions
;; (add-hook 'find-file-not-found-hooks
;;           '(lambda ()
;;              (if (equal (file-name-extension (buffer-file-name)) "java")
;;                  (progn
;;                    (java-mode)
;;                    (insert-java-template)
;;                    (message "Inserted java template")))

;;              (if (equal (file-name-extension (buffer-file-name)) "html")
;;                  (progn
;;                    (nxml-mode)
;;                    (insert-html5-template)
;;                    (message "Inserted xhtml template")))))

(setq custom-file "~/.emacs.d/aj/init-custom.el")
(load custom-file 'noerror)

;; Turn of debug
(setq debug-on-error nil)
;; Start server
(server-start)
(message "loaded init.el")
(provide 'init)
;;; init.el ends here
