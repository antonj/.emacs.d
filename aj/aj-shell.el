(defun clear-shell ()
  (interactive)
  (message "clear buffer")
  (comint-clear-buffer))


(defun aj-shell-hook()
  (local-set-key (kbd "C-c C-k") 'clear-shell))

(add-hook 'shell-mode-hook 'aj-shell-hook)

(provide 'aj-shell)
