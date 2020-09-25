(defun aj-emacs-lisp-hook ()
  (add-hook 'before-save-hook #'iwb t t)
  (eldoc-mode t))
(add-hook 'emacs-lisp-mode-hook 'aj-emacs-lisp-hook)

(provide 'aj-elisp)
