;; Ediff
(set-variable 'ediff-split-window-function 'split-window-horizontally)


;; TODO: fix, this adds a lot of hooks without removing them!
(add-hook 'ediff-mode-hook
          (lambda ()
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
                     (set-window-configuration
                      ediff-saved-window-configuration))))
              (add-hook 'ediff-quit-hook
                        restore-frame-configuration 'append)
              (add-hook 'ediff-suspend-hook
                        restore-frame-configuration 'append))) 'append)

(provide 'aj-ediff)
