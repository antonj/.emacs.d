;; room.js(7,1): error TS2322: Type '"hej"' is not assignable to type 'number'.

(flycheck-define-checker typescript-checkjs-checker
  ""
  :command ("tsc"
            "--jsx"
            "preserve"
            "--baseUrl" "."
            "--checkJs"
            "--allowJs"
            "--target" "ESNext" ;; "ES6"
            "--moduleResolution" "Node"
            "--module" "amd"
            "--outFile" "/dev/null"
            source-inplace)
  :error-patterns
    ((error line-start (file-name) "(" line "," column "): error " (message) line-end))
  :modes rjsx-mode
)


(eval-after-load 'flycheck
  '(add-to-list 'flycheck-checkers 'typescript-checkjs-checker t))

(provide 'flymake-typescript-checkjs)
