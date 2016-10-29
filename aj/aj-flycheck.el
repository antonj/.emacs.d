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

;; npm install -g standard
(with-eval-after-load 'flycheck
  (flycheck-add-next-checker 'javascript-eslint 'javascript-flow 'javascript-standard)

  (flycheck-add-mode 'javascript-eslint 'js-mode)
  (flycheck-add-mode 'javascript-standard 'js-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-add-mode 'javascript-standard 'js2-mode)
  (flycheck-add-mode 'css-csslint 'css-mode))


;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(json-jsonlist)))

(provide 'aj-flycheck)
