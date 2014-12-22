(add-hook 'magit-mode-hook
          (lambda ()
            (local-set-key "\M-1" 'beginning-of-buffer)
            (local-set-key "\M-2" 'end-of-buffer)
            (local-set-key (kbd "1") 'magit-show-level-1-all)
            (local-set-key (kbd "2") 'magit-show-level-2-all)
            (local-set-key (kbd "3") 'magit-show-level-3-all)
            (local-set-key (kbd "4") 'magit-show-level-4-all)
            (local-set-key "\M-s" 'speedbar-get-focus)
            (local-set-key [(c)] 'git-commit)))

(provide 'aj-magit)
