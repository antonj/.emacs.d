;; Enable ibuffer-filter-by-filename to filter on directory names too.
;; From http://www.emacswiki.org/emacs/IbufferMode
(eval-after-load "ibuf-ext"
  '(define-ibuffer-filter filename
       "Toggle current view to buffers with file or directory name matching QUALIFIER."
     (:description "filename"
                   :reader (read-from-minibuffer "Filter by file/directory name (regexp): "))
     (ibuffer-awhen (or (buffer-local-value 'buffer-file-name buf)
                        (buffer-local-value 'dired-directory buf))
                    (string-match qualifier it))))

(setq ibuffer-saved-filter-groups
      '(("home"
         ("emacs-config" (or (filename . ".emacs.d")
                             (filename . "emacs-config")))
         ;; ("org-mode" (or (mode . org-mode)
         ;;                 (filename . "OrgMode")))
         ("department-http" (filename . "department-http"))
         ("department" (filename . "department"))
         ("monterosa-http" (filename . "monterosa-http"))
         ("monterosa" (filename . "monterosa"))
         ("sites" (filename . "Sites"))
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
         ("git" (or (name . "\*magit")
                    (name . "\*git")))
         )))

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-g") 'ibuffer-quit)
             (ibuffer-switch-to-saved-filter-groups "home")))
(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-expert t)

(provide 'aj-ibuffer)
