;; Ediff
(custom-set-variables
 ;; No whitespace
 ;;'(ediff-diff-options "-w") 
 '(ediff-split-window-function (quote split-window-horizontally))
 ;; No extra frame
 '(ediff-window-setup-function (quote ediff-setup-windows-plain)))

;; TODO: fix, this adds a lot of hooks without removing them!
(add-hook 'ediff-before-setup-hook
          (lambda ()
            ;; (setq ediff-saved-frame-configuration
            ;;       (current-frame-configuration))
            (setq ediff-saved-window-configuration
                  (current-window-configuration))))

(let ((restore-frame-configuration
       (lambda ()
         ;; (set-frame-configuration
         ;;  ediff-saved-frame-configuration)
         ;; Fulfix dedicated window Emacs24
         (set-window-configuration
          ediff-saved-window-configuration))))
  (add-hook 'ediff-quit-hook restore-frame-configuration 'append)
  (add-hook 'ediff-suspend-hook restore-frame-configuration 'append))

(provide 'aj-ediff)
