(add-hook 'markdown-mode-hook
          '(lambda ()
             (visual-line-mode t)
             (local-set-key (kbd "TAB") 'markdown-cycle)
             (local-set-key "\M-n" 'just-one-space)))
(provide 'aj-markdown)
