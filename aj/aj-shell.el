(defun clear-shell ()
  (interactive)
  (message "clear buffer")
  (comint-clear-buffer))


(defun aj-shell-hook()
  (local-set-key (kbd "C-c C-k") 'clear-shell)
  ;; `shell-mode' output is transient terminal text, so buffer highlighters
  ;; tend to produce misleading neon overlays on top of command output.
  (when (fboundp 'idle-highlight-in-visible-buffers-mode)
    (idle-highlight-in-visible-buffers-mode -1))
  (when (fboundp 'hl-line-mode)
    (hl-line-mode -1)))

(add-hook 'shell-mode-hook 'aj-shell-hook)

(provide 'aj-shell)
