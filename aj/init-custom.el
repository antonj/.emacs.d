(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'pushy)
 '(cursor-type 'box)
 '(custom-safe-themes
   '("0d144d89d0495f84204e94e1475747e71634e13ba8841ff28a90ad80e164002a" default))
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
   '(highlight-indent-guides use-package company gradle-mode swift3-mode adaptive-wrap docker shell-here drag-stuff auto-complete php+-mode php-mode add-node-modules-path multiple-cursors prettier-js vue-mode ac-capf neotree ag srefactor ido-completing-read+ ido-ubiquitous js-import dockerfile-mode graphql-mode golint protobuf-mode go-mode browse-kill-ring wgrep wgrep-ag nil swift-mode slim-mode))
 '(paren-match-face 'paren-face-match-light)
 '(paren-sexp-mode t)
 '(safe-local-variable-values
   '((whitespace-style face tabs trailing lines-tail)
     (eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
           (add-hook 'write-contents-functions
                     (lambda nil
                       (delete-trailing-whitespace)
                       nil))
           (require 'whitespace)
           "Sometimes the mode needs to be toggled off and on."
           (whitespace-mode 0)
           (whitespace-mode 1))
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
