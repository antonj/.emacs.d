(defun aj-magit-mode-hook()
  (local-set-key "\M-1" 'beginning-of-buffer)
  (local-set-key "\M-2" 'end-of-buffer)
  (local-set-key (kbd "1") 'magit-section-show-level-1-all)
  (local-unset-key (kbd "C-<tab>"))
  (local-set-key (kbd "2") 'magit-section-show-level-2-all)
  (local-set-key (kbd "3") 'magit-section-show-level-3-all)
  (local-set-key (kbd "4") 'magit-section-show-level-4-all)
  (local-set-key "\M-s" 'neotree-project-dir)
  ;;(local-set-key [(c)] 'git-commit)
  )

(setq magit-diff-refine-hunk (quote all))
(add-hook 'magit-mode-hook 'aj-magit-mode-hook)

(defun aj-git-commit-mode()
  (auto-fill-mode -1)
  (flyspell-mode 1)
  )
(add-hook 'git-commit-mode-hook 'aj-git-commit-mode)


(provide 'aj-magit)
;;; aj-magit ends here
