;;; package --- hej
;;; Commentary: grejsneo
;;; Code:

(add-to-list 'load-path (expand-file-name "~/.emacs.d/aj"))

;; (define-advice make-frame (:around (fn &rest args) suppress)
;;   "Suppress making new frame; return existing frame."
;;   (message "make-frame suppressed; proceed at your own peril.")
;;   (selected-frame))


(setenv "GOPATH" "/Users/antonj/Documents/department/telness-platform/backend:/Users/antonj/go")


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(require 'cl)
(require 'aj-generic)

(use-package color-theme)
(use-package git-timemachine)
(use-package adaptive-wrap
  :config
  (progn (add-hook
          'visual-line-mode-hook #'adaptive-wrap-prefix-mode)
         (setq-default adaptive-wrap-extra-indent 1)))
(use-package json-mode)
(use-package shell-here
  :config (progn (global-set-key (kbd "C-t") 'shell-here)))
(use-package yaml-mode
  :config (progn
            (defun aj-yaml-mode-hook ()
              (highlight-indentation-mode)
              (highlight-indentation-current-column-mode)
              (local-set-key (kbd "C-M-i") 'aj-toggle-fold))
            (add-hook 'yaml-mode-hook 'aj-yaml-mode-hook)))
(use-package go-mode
  :config (progn
            (defun aj-go-mode-hook ()
              (message "go-mode-hook")
              ;;(auto-complete-mode 1)
              ;;(setq gofmt-command "goimports")
              ;;(go-eldoc-setup)
              (subword-mode t)
              (add-hook 'before-save-hook #'lsp-format-buffer t t)
              (add-hook 'before-save-hook #'lsp-organize-imports t t)
              )


              ;; (setq compile-command "go build -v && go test -v && go vet && golint")
              ;; (local-set-key (kbd "M-.") 'godef-jump)
              ;; (local-set-key (kbd "M-,") 'pop-tag-mark)
              ;; (setq 'ac-sources '('ac-source-go))
              ;; (add-hook 'before-save-hook 'gofmt-before-save)
            (add-hook 'go-mode-hook #'lsp-deferred)
            (add-hook 'go-mode-hook 'aj-go-mode-hook)))
(use-package ag) ;;  brew install the_silver_searcher

(use-package wgrep-ag
  :config (progn
            (setq wgrep-enable-key (kbd "C-x C-q"))
            (defun aj-wgrep-setup ()
              (define-key wgrep-mode-map (kbd "C-c C-q") 'wgrep-abort-changes))
            (setq wgrep-setup-hook 'aj-wgrep-setup)
            ))
(use-package prettier-js
  :config (progn
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
(use-package js2-mode)
(use-package typescript-mode
  :config (progn
            ;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
            ;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
            (defun aj-typescript-mode-hook ()
              (company-mode t)
              ;; (lsp-javascript-typescript-enable)
              (prettier-js-mode)
              (setq typescript-indent-level 2)
              )
            (add-hook 'typescript-mode-hook 'aj-typescript-mode-hook)
            ))
(use-package company
  :config (progn
            (global-company-mode)
            (setq company-tooltip-align-annotations t)
            (setq company-idle-delay 0.2)
            (setq company-minimum-prefix-length 2)
            (global-set-key (kbd "C-M-j") 'company-complete)
            
            (define-key company-active-map [tab] 'company-complete-selection)
            (define-key company-active-map "\C-w" nil)
            (define-key company-active-map (kbd "TAB") 'company-complete-selection)
            (define-key company-active-map (kbd "C-n") 'company-select-next)
            (define-key company-active-map (kbd "C-p") 'company-select-previous)
            ))
;; (:name company-lsp
;;        :type elpa
;;        :after (progn
;;                 (require 'company-lsp)
;;                 (setq company-lsp-async t)

;;                 (define-key company-active-map [tab] 'company-complete-selection)
;;                 (define-key company-active-map "\C-w" nil)
;;                 (define-key company-active-map (kbd "TAB") 'company-complete-selection)
;;                 (define-key company-active-map (kbd "C-n") 'company-select-next)
;;                 (define-key company-active-map (kbd "C-p") 'company-select-previous)

;;                 (push 'company-lsp company-backends)
;;                 ))
(use-package company-emoji
  :config (progn
            (add-to-list 'company-backends 'company-emoji)
            ))
(use-package js-import
  :config (progn
            (defun js-import-is-js-file (filename)
              "Check if FILENAME ends with either .js or .jsx."
              (or (js-import-string-ends-with-p filename ".js")
                  (js-import-string-ends-with-p filename ".jsx")
                  (js-import-string-ends-with-p filename ".tsx")
                  (js-import-string-ends-with-p filename ".ts")))
            ))
(use-package rjsx-mode
  :config (progn
            (defun aj-rjsx-mode-hook ()
              (subword-mode t)
              (prettier-js-mode t)
              (auto-complete-mode -1)
              (eldoc-mode -1)
              (flycheck-mode t)

              (add-node-modules-path)
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
(use-package lsp-mode
  :config (progn
            (push "/backend/src/telness/vendor" lsp-file-watch-ignored)
            (push "/backend/pkg" lsp-file-watch-ignored)
            (defun aj-lsp-mode-hook ()
              (local-set-key (kbd "C-<return>") 'lsp-execute-code-action)
              (local-set-key (kbd "C-M-j") 'company-complete))
            (add-hook 'lsp-mode-hook 'aj-lsp-mode-hook)))
(use-package lsp-treemacs
  :config (progn (lsp-treemacs-sync-mode 1)))
(use-package lsp-ui)
(use-package company-quickhelp)
(use-package editorconfig ;; brew install editorconfig
  :config (progn
            (editorconfig-mode 1)))
(use-package graphql-mode
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.gql\\'" . graphql-mode))
            (defun aj-graphql-mode-hook ()


              ;;npm i -g graphql-language-service-interface
              ;;npm install -g graphql-cli

              (subword-mode t))
            (add-hook 'graphql-mode-hook 'aj-graphql-mode-hook)))
(use-package protobuf-mode
  :config (progn
            (defun aj-protobuf-mode-hook ()
              (subword-mode t))
            (add-hook 'protobuf-mode-hook 'aj-protobuf-mode-hook)))
(use-package neotree
  :config (progn
            (defun neotree-project-dir ()
              "Open NeoTree using the git root."
              (interactive)
              (set-variable 'neo-window-width 30)

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
(use-package all-the-icons)
(use-package undo-tree)
;; (:name color-theme-solarized :type elpa)
;; (:name project-explorer
;;        :after (progn
;;                 (setq pe/width 25)
;;                 (setq pe/omit-regex "^.next\\|^.cache\\|^.DS_Store\\|^#\\|~$\\|^node_modules$\\|[.]pb[.]go$")
;;                 (defun aj-project-explorer-mode-hook() (sticky-buffer-window))
;;                 (add-hook 'project-explorer-mode-hook 'aj-project-explorer-mode-hook)
;;        (define-key project-explorer-mode-map "\M-s" 'previous-multiframe-window)))
(use-package paredit)
(use-package slim-mode
  :config (progn
            (defun aj-slim-mode-hook()
              (highlight-indentation-mode)
              (highlight-indentation-current-column-mode))
            (add-hook 'slim-mode-hook 'aj-slim-mode-hook)))
(use-package seq)
(use-package drag-stuff
  :config (progn
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

            (define-key drag-stuff-mode-map (kbd "M-π") 'drag-stuff-up)
            (define-key drag-stuff-mode-map (kbd "M-‘") 'drag-stuff-down)
            (define-key drag-stuff-mode-map (drag-stuff--kbd 'right) 'shift-right)
            (define-key drag-stuff-mode-map (drag-stuff--kbd 'left) 'shift-left)
            ))
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(use-package add-node-modules-path)
(use-package web-mode
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

            (defun aj-web-mode-hook ()
              (add-node-modules-path)
              (setq web-mode-markup-indent-offset 2)
              (setq web-mode-css-indent-offset 2)
              (setq web-mode-code-indent-offset 2)
              (setq web-mode-enable-auto-quoting nil)
              (highlight-indentation-mode t)
              (subword-mode)
              (local-set-key (kbd "C-M-j") 'company-complete)
              ;; (company-mode t)

              ;; npm i -g javascript-typescript-langserver
              ;; (lsp-javascript-typescript-enable)


              ;; https://github.com/theia-ide/typescript-language-server
              ;; npm install -g typescript-language-server
              ;; (lsp-typescript-enable)
              (prettier-js-mode t))

            (add-hook 'web-mode-hook 'aj-web-mode-hook)
            (add-hook 'web-mode-hook #'lsp-deferred)

            ;; for better jsx syntax-highlighting in web-mode
            ;; - courtesy of Patrick @halbtuerke
            ;;                   (defadvice web-mode-highlight-part (around tweak-jsx activate)
            ;;                     (if (equal web-mode-content-type "jsx")
            ;;                         (let ((web-mode-enable-part-face nil))
            ;;                           ad-do-it)
            ;;                       ad-do-it))
            ))
(use-package flx) ;; Flex matching fuzzy stuff
(use-package flx-ido) ;; Flex matching fuzzy stuff
(use-package projectile
  :config (progn
            (projectile-global-mode)
            ;; (define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
            ;; (define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
            (define-key projectile-mode-map (kbd "C-x C-j") 'projectile-find-file)
            ;; (define-key projectile-mode-map [?\s-g] 'projectile-grep)
            ))
(use-package highlight-indentation
  :config (progn
            (setq highlight-indentation-offset 2)))
(use-package scss-mode
  :config (progn
            (setq scss-compile-at-save nil)
            (setq scss-sass-options ())
            (defun aj-scss-mode-hook()
              (setq cssm-indent-function #'cssm-c-style-indenter)
              ;; (setq scss-sass-options '("--style" "compressed"))
              (rainbow-mode t))
            (add-hook 'scss-mode-hook 'aj-scss-mode-hook)))
(use-package highlight-parentheses
  :config (progn
            (highlight-parentheses-mode)))
(use-package multiple-cursors
  :config (progn
            (global-set-key (kbd "C-S-n") 'mc/mark-next-like-this)
            (global-set-key (kbd "C-S-p") 'mc/mark-previous-like-this)
            (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
            (global-set-key (kbd "C-S-c C-S-v") 'mc/mark-all-like-this)))
(use-package markdown-mode
  :config (progn
            (defun aj-markdown-mode-hook ()
              (visual-line-mode t)
              (prettier-js-mode)
              (auto-fill-mode -1)
              (markdown-toggle-wiki-links t)
              (local-set-key (kbd "TAB") 'markdown-cycle)
              ;;(local-set-key (kbd "S-TAB") 'markdown-outdent-region)
              (local-set-key "\M-n" 'just-one-space))
            (add-hook 'markdown-mode-hook 'aj-markdown-mode-hook)))
;;(use-package framemove
;;  :config (progn
;;            (windmove-default-keybindings)
;;            (setq framemove-hook-into-windmove t)))
(use-package jade-mode
  :config (progn
            (defun aj-jade-mode-hook ()
              (highlight-indentation-mode)
              (highlight-indentation-current-column-mode))
            (add-hook 'jade-mode-hook 'aj-jade-mode-hook)))
;; (use-package rcirc-notify
;;        :type git
;;        :url "https://github.com/antonj/rcirc-notify-el.git"
;;        :features rcirc-notify)
(use-package yasnippet
  :config (progn
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
(use-package multi-term
  :config (progn
            (eval-after-load "mutli-term" '(require 'aj-term))))
(use-package rainbow-mode)
;; TODO
;; (use-package git-emacs
;;        :type git
;;        :url "https://github.com/tsgates/git-emacs.git"
;;        :config (progn
;;                 (require 'git-emacs)
;;                 (require 'git-status)))
(use-package magit
  :config (progn
            (message "magit after")
            (require 'aj-magit)))
(use-package ido-vertical-mode
  :config (progn
            (ido-mode 1)
            (ido-vertical-mode 1)
            (setq ido-vertical-define-keys 'C-n-and-C-p-only)))
(use-package ido-completing-read+
  :config (progn (ido-ubiquitous-mode 1)))
(use-package auto-complete
  :config (progn
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
;;))

;; Personal
(add-hook 'sws-mode-hook
          '(lambda ()
             (highlight-indentation-mode)
             (highlight-indentation-current-column-mode)))

(autoload 'less-mode "less-mode")
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-mode))

(add-to-list 'auto-mode-alist '("\\.vue\\'" . javascript-mode))

(defun aj-php-mode-hook ()
  """ npm install --global prettier @prettier/plugin-php"""
  (prettier-js-mode t))
(add-hook 'php-mode-hook 'aj-php-mode-hook)

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
(add-to-list 'auto-mode-alist '(".env" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".env-sample" . shell-script-mode))


;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal/lsp-javascript/"))
;; (require 'lsp-javascript-typescript)
;; (require 'lsp-typescript)


;; (require 'aj-magit)
(require 'aj-shell)
(require 'aj-color)
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


(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(require 'framemove)
(windmove-default-keybindings)
(setq framemove-hook-into-windmove t)


(setq custom-file "~/.emacs.d/aj/init-custom.el")
(load custom-file 'noerror)

;; Turn of debug
(setq debug-on-error nil)
;; Start server
(server-start)
(message "loaded init.el")
(provide 'init)
;;; init.el ends here
