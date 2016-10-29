(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))

(defun aj-ruby-mode-hook ()
  (highlight-indentation-mode)
  (highlight-indentation-current-column-mode))

(add-hook 'ruby-mode-hook 'aj-ruby-mode-hook)

(provide 'aj-ruby)
