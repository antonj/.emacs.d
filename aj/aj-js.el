;; Add "support" for js files in speedbar, interpreted as c
;; (speedbar-add-supported-extension ".js")
;; (add-to-list 'speedbar-fetch-etags-parse-list
;;              '("\\.js" . speedbar-parse-c-or-c++tag))

(setq js2-mirror-mode nil)
(setq sgml-basic-offset 2)


;; (defun my-js2-mode-hook ()
;;   (define-key js2-mode-map [(meta q)] 'c-fill-paragraph)
;;   (define-key js2-mode-map [(return)] 'newline-and-indent)
;;   (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
;;   (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
;;   (define-key js2-mode-map [(meta j)] 'hippie-expand)

;;   ;; npm install -g tern
;;   ;; M-x package-install tern
;;   ;; M-x package-install tern-auto-complete
;;   (tern-mode t)
;;   (eval-after-load 'tern
;;     '(progn
;;        (tern-ac-setup)))
;;   (electric-indent-local-mode -1)
;;   (highlight-indentation-mode)
;;   (projectile-mode)
;;   (highlight-indentation-current-column-mode)
;;   )

;; (add-hook 'js2-mode-hook 'my-js2-mode-hook)




(defun my-js-mode-hook ()
  (define-key js-mode-map [(meta q)] 'c-fill-paragraph)
  (define-key js-mode-map [(return)] 'newline-and-indent)
  (define-key js-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js-mode-map [(meta j)] 'hippie-expand)
  (define-key js-mode-map (kbd "<tab>") 'aj-indent-relative)
  (subword-mode) ;; CamelCase aware kill-word
  (setq js-indent-level 2)
  (tern-mode t)
  (eval-after-load 'tern
    '(progn
       (require 'tern-auto-complete)
       (tern-ac-setup)))
  ;;(auto-complete-flowtype-setup)
  (auto-complete-mode)
  (electric-indent-local-mode -1)
  (projectile-mode)
  (highlight-indentation-mode)
  (highlight-indentation-current-column-mode)
  )

(defun my-js2-mode-hook ()
  (prettier-js-mode t)
  (my-js-mode-hook)
  (setq-default js2-basic-offset 2)
  (setq-default js-switch-indent-offset 2)
  (setq-default js2-include-node-externs t)
  (setq-default js2-include-browser-externs t)
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-missing-semi-one-line-override nil)
  (setq-default js2-mode-indent-ignore-first-tab t)
  (setq-default js2-show-parse-errors nil)
  (setq-default js2-strict-inconsistent-return-warning nil)
  (setq-default js2-strict-var-hides-function-arg-warning nil)
  (setq-default js2-strict-trailing-comma-warning nil)
  (setq-default js2-strict-cond-assign-warning nil)
  (setq-default js2-strict-var-redeclaration-warning nil)

  (define-key js2-mode-map [(meta q)] 'c-fill-paragraph)
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(meta j)] 'hippie-expand)
  )

(add-hook 'js-mode-hook 'my-js-mode-hook)
(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(provide 'aj-js)
