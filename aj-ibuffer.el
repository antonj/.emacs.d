(setq ibuffer-saved-filter-groups
      '(("home"
         ("emacs-config" (or (filename . ".emacs.d")
                             (filename . "emacs-config")))
         ;; ("org-mode" (or (mode . org-mode)
         ;;                 (filename . "OrgMode")))
         ("monterosa-http" (filename . "monterosa-http"))
         ("monterosa" (filename . "monterosa"))
         ("exjobb" (filename . "exjobb"))
         ("code" (filename . "code"))
         ("siine" (filename . "siine"))
         ("skola" (filename . "skola"))
         ("public_html" (filename . "public_html"))
         ("msg" (or (mode . rcirc-mode)
                    (name . "jabber")))
         ("files" (filename . ".+"))
         ("help" (or (name . "\*Help\*")
                     (name . "\*Apropos\*")
                     (name . "\*info\*")))
         ("shells" (mode . shell-mode))
         ("svn" (name . "\*svn"))
         ("git" (name . "\*git"))
         )))

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-g") 'ibuffer-quit)
             (ibuffer-switch-to-saved-filter-groups "home")))
(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-expert t)

(provide 'aj-ibuffer)
