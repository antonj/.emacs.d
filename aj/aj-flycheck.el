;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
;; npm install -g eslint
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

(require 'flycheck-flow)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal/flymake-typescript-checkjs"))
(require 'flymake-typescript-checkjs)

;; npm install -g standard
;; npm install -g eslint babel-eslint eslint-plugin-react


;; (set-variable flycheck-idle-change-delay 0.5)
(setq flycheck-check-syntax-automatically '(mode-enabled save))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'js-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-add-mode 'javascript-eslint 'rjsx-mode)

  (set-variable flycheck-highlighting-mode "lines")

  ;; (flycheck-add-next-checker 'javascript-eslint 'typescript-checkjs-checker)
  ;; (flycheck-add-next-checker 'typescript-checkjs-checker 'javascript-eslint)
)


;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(json-jsonlist)))

(provide 'aj-flycheck)
