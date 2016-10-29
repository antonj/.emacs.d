(require 'auto-complete)
(require 'json)

(defvar flow-program "flow")

(defun auto-complete-flowtype--get-completions ()
  (assoc-default
   'result
   (json-read-from-string
    (with-output-to-string
      (let ((line (line-number-at-pos))
            (col (1+ (current-column))))
        (call-process-region
         (point-min) (point-max) flow-program nil standard-output nil
         "autocomplete"
         "--json"
         (number-to-string line)
         (number-to-string col)))))))

(defun auto-complete-flowtype--prefix ()
  (when (re-search-backward "\\(?:\\.\\)\\(\\(?:[a-zA-Z0-9][_a-zA-Z0-9]*\\)?\\)\\=" nil t)
    (match-beginning 1)))

(defun auto-complete-flowtype--candidates ()
  (mapcar
   (lambda (c)
     (popup-make-item
      (assoc-default 'name c)
      :summary (assoc-default 'type c)))
   (auto-complete-flowtype--get-completions)))

(ac-define-source flowtype
                  '((candidates . auto-complete-flowtype--candidates)
                    (prefix . auto-complete-flowtype--prefix)
                    (requires . 0)))

(defun auto-complete-flowtype-setup ()
  (add-to-list 'ac-sources 'ac-source-flowtype))

(provide 'auto-complete-flowtype)
