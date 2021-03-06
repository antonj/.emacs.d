(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-use-filename-at-point 'nil)
(setq ido-show-dot-for-dired nil)

;; Flx
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
;; ;; disable ido faces to see flx highlights.
;; ;; (setq ido-use-faces nil)

(defun ido-aj-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map "\C-w" 'ido-delete-backward-word-updir))
(add-hook 'ido-setup-hook 'ido-aj-keys)

(provide 'aj-ido)
