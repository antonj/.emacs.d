(defun aj-magit-mode-hook()
  (local-set-key "\M-1" 'beginning-of-buffer)
  (local-set-key "\M-2" 'end-of-buffer)
  (local-set-key (kbd "1") 'magit-section-show-level-1-all)
  (local-unset-key (kbd "C-<tab>"))
  (local-set-key (kbd "2") 'magit-section-show-level-2-all)
  (local-set-key (kbd "3") 'magit-section-show-level-3-all)
  (local-set-key (kbd "4") 'magit-section-show-level-4-all)
  (local-set-key "\M-s" 'neotree-project-dir)


  (setq magit-list-refs-sortby "-committerdate")
  (with-eval-after-load 'transient
    (add-to-list 'transient-values
                 '(magit-show-refs ("--sort=-committerdate"))))
  ;;(setq magit-diff-options '(""))

  ;;(local-set-key [(c)] 'git-commit)
  )

(setq magit-diff-refine-hunk (quote all))
(require 'aj-magit-line-counts)
(add-hook 'magit-mode-hook 'aj-magit-mode-hook)

(defun aj-magit-tty-faces ()
  (unless (display-graphic-p)
    (face-remap-add-relative 'magit-section-highlight 'hl-line)))

(add-hook 'magit-mode-hook 'aj-magit-tty-faces)

(defun aj-git-commit-mode()
  (auto-fill-mode -1)
  (flyspell-mode 1)
  )
(add-hook 'git-commit-mode-hook 'aj-git-commit-mode)

;; (remove-hook 'magit-status-sections-hook #'magit-insert-worktrees)
;; (add-hook 'magit-status-sections-hook #'magit-insert-worktrees)

(with-eval-after-load 'magit
  (remove-hook 'magit-status-sections-hook #'magit-insert-worktrees)
  (let ((pos (memq #'magit-insert-status-headers
                   magit-status-sections-hook)))
    (when pos
      (setcdr pos
              (cons #'magit-insert-worktrees
                    (remove #'magit-insert-worktrees (cdr pos)))))))

(setq magit-commit-show-diff nil)



(provide 'aj-magit)
;;; aj-magit ends here
