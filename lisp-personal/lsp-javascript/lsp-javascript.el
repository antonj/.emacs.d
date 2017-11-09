;;; lsp-javascript.el --- Javascript support for lsp-mode, through https://github.com/sourcegraph/javascript-typescript-langserver

;;; Commentary:
;; Bye linter

;; Author: Anton Johansson <anton.johansson@gmail.com>
;; Version: 1.0
;; Package-Requires: ((lsp-mode "2.0") (rjsx-mode "1.1"))
;; Keywords: javascript, typescript, lsp

(require 'lsp-mode)
(require 'go-mode)

;;; Code:

;;;###autoload
(lsp-define-stdio-client 'js-mode "typescript" 'stdio
                         #'(lambda () default-directory)
                         "Javascript Language Server"
                         '("javascript-typescript-stdio"))

(provide 'lsp-javascript)
;;; lsp-javascript.el ends here
