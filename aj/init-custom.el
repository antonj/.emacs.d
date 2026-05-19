(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'pushy)
 '(cursor-type 'box)
 '(custom-safe-themes
   '("414f02a764e8b0ee8dd50a007a06b0faf8b59f204db4ff36ad45501e76d86778"
     "55f0047afc0b72c44f4dcc54b50e9b8aab43bc7d99ac336b9b90f9f39966b606"
     "58083a9001b7a319f7f5a6b5f336e9927e8fdba816fb0c2d27a2ed40c95a8a52"
     "6c5556eacfc2e1d3444595c8d4fb7ddb9075e7ce5dd52f3070c49a54750d4e18"
     "2101c77fd533290e2646e221cf29a2adc6a8cd4698d8f5277656da80020dc6eb"
     "2cb4affb136b67471e4b980d8c5ca86c2d96fd0edb10049d139cf31240a89ec2"
     "3793658487692948db9439c37d8aeaa849aa5d236839062c253095ba82fe0785"
     "da939eb69be394037c5dd7570d22abbb43ffc0829d3f57215fcccf45162f4178"
     "53162ee30640a1057549231ffe2f0f956a4aff1d94f5b7a4c085d7abb4dce6c9"
     "afe11c837eca69f0f7fa6fbf0d23d261f9225b69d47ffadb7c88acfdad99df58"
     "3f687c0b9a5311391e44dcd8485da1992826f09df05d1368c0daa1192c6bdf7e"
     "fd8de91137b97a167afb93dc9ce7667d3af6a59ae4762e5cd7142d1637c0fddb"
     "ea3b0a560fb8dde02f7df21d82ca96e167bc3365ee19bfb5085abbee552d4a03"
     "547ac98e5e5663e2aa5bf2299192b08c6a250c44a1a5209d7bfe59e6d8ca242f"
     "570c4029ed23e05bb6f04ae28cb9d5cf1922af838ae13ed94e9abfc1d8e8a77d"
     "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045"
     "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da"
     "43f03c7bf52ec64cdf9f2c5956852be18c69b41c38ab5525d0bedfbd73619b6a"
     "0d144d89d0495f84204e94e1475747e71634e13ba8841ff28a90ad80e164002a"
     default))
 '(ecb-options-version "2.40")
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(git-state-modeline-decoration 'git-state-decoration-large-dot)
 '(jabber-chat-buffer-show-avatar nil)
 '(jabber-show-offline-contacts nil)
 '(jde-jdk '("1.6"))
 '(jde-jdk-registry
   '(("1.6" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.6")))
 '(lsp-project-whitelist '("^/Users/antonj/Documents/department-http/hyperisland/$"))
 '(ns-alternate-modifier nil)
 '(org-agenda-files '("~/Documents/org/notes.org"))
 '(package-selected-packages
   '(ac-capf adaptive-wrap add-node-modules-path ag ample-theme
             auto-complete badger-theme biomejs-format
             browse-kill-ring clojure-mode company counsel docker
             dockerfile-mode drag-stuff go-mode golint gradle-mode
             graphql-mode groovy-mode highlight-indent-guides
             idle-highlight-in-visible-buffers-mode
             ido-completing-read+ ido-ubiquitous ivy js-import
             kaolin-themes kotlin-mode multiple-cursors neotree nil
             php+-mode php-mode prettier-js protobuf-mode shell-here
             slim-mode srefactor swift-mode swift3-mode swiper
             use-package vterm vue-mode wgrep wgrep-ag))
 '(paren-match-face 'paren-face-match-light)
 '(paren-sexp-mode t)
 '(safe-local-variable-values
   '((whitespace-style face tabs trailing lines-tail)
     (eval ignore-errors
           "Write-contents-functions is a buffer-local alternative to before-save-hook"
           (add-hook 'write-contents-functions
                     (lambda nil (delete-trailing-whitespace) nil))
           (require 'whitespace)
           "Sometimes the mode needs to be toggled off and on."
           (whitespace-mode 0) (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face trailing lines-tail)
     (require-final-newline . t)))
 '(send-mail-function 'mailclient-send-it))


;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:background "#eeeedd" :foreground "#333344"))))
;;  '(cursor ((t (:background "red"))))
;;  '(dired-directory ((t (:inherit font-lock-function-name-face))))
;;  '(flymake-errline ((((class color)) (:underline "OrangeRed"))))
;;  '(flymake-warnline ((((class color)) (:underline "yellow"))))
;;  '(flyspell-duplicate ((t (:underline "Gold3"))))
;;  '(flyspell-incorrect ((t (:underline "OrangeRed"))))
;;  '(font-latex-bold-face ((t (:weight bold))))
;;  '(font-latex-italic-face ((t (:slant italic))))
;;  '(ido-first-match ((t (:inherit font-lock-string-face))))
;;  '(ido-first-match-face ((t (:inherit font-lock-string-face))))
;;  '(ido-only-match ((t (:inherit font-lock-string-face :weight bold))))
;;  '(ido-subdir ((t (:inherit font-lock-function-name-face))))
;;  '(minibuffer-prompt ((t (:foreground "black"))))
;;  '(org-hide ((((background light)) (:foreground "dim gray")) (((background dark)) (:foreground "dim gray"))))
;;  '(org-level-1 ((t (:foreground "gold" :height 1.2))))
;;  '(org-level-2 ((t (:foreground "gray80" :height 1.1)))))


;; '(default-frame-alist (quote ((tool-bar-lines . 0) (mouse-color . "black") (foreground-color . "black") (cursor-color . "red") (border-color . "#888a85") (background-mode . light) (background-color . "#eeeedd") (menu-bar-lines . 1) (cursor-type . box) (vertical-scroll-bars) (internal-border-width . 0) (left-fringe . 1) (right-fringe) (fringe) (vc-annotate-very-old-color . "#0046FF") (senator-eldoc-use-color . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "red"))))
 '(flymake-error ((((class color)) (:underline "OrangeRed"))))
 '(flymake-warning ((((class color)) (:underline "yellow"))))
 '(jabber-title-large ((t (:inherit variable-pitch :weight bold :height 1.3 :width ultra-expanded))))
 '(jabber-title-medium ((t (:inherit variable-pitch :weight bold :height 1.1 :width expanded))))
 '(org-hide ((((background light)) (:foreground "dim gray")) (((background dark)) (:foreground "dim gray")))))
