;; Add "support" for js files in speedbar, interpreted as c
;; (speedbar-add-supported-extension ".js")
;; (add-to-list 'speedbar-fetch-etags-parse-list
;;              '("\\.js" . speedbar-parse-c-or-c++tag))

(setq js2-mirror-mode nil)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))

(defun my-js2-mode-hook ()
  (define-key js2-mode-map [(meta q)] 'c-fill-paragraph)
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(meta j)] 'hippie-expand)
  (setq js2-basic-offset 2)

  ;; npm install -g tern
  ;; M-x package-install tern
  ;; M-x package-install tern-auto-complete
  (tern-mode t)
  (eval-after-load 'tern
    '(progn
       (tern-ac-setup)))
  (electric-indent-local-mode -1)
  (highlight-indentation-mode)
  (projectile-mode)
  (highlight-indentation-current-column-mode)
  )

(add-hook 'js2-mode-hook 'my-js2-mode-hook)


(defun my-js-mode-hook ()
  (define-key js-mode-map [(meta q)] 'c-fill-paragraph)
  (define-key js-mode-map [(return)] 'newline-and-indent)
  (define-key js-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js-mode-map [(meta j)] 'hippie-expand)
  (setq js-indent-level 2)
  (tern-mode t)
  (eval-after-load 'tern
    '(progn
       (tern-ac-setup)))
  (electric-indent-local-mode -1)
  (projectile-mode)
  (highlight-indentation-mode)
  (highlight-indentation-current-column-mode)
  )
(add-hook 'js-mode-hook 'my-js-mode-hook)

(provide 'aj-js)
