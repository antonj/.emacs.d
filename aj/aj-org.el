(defun aj-org-mode-hook()
  ;;(flyspell-mode t)
  ;;(ispell-change-dictionary "sv" nil)
  (auto-fill-mode 1)
  (local-set-key (kbd "C-<return>") 'org-export-as-html-and-open)
  ;; Will mess up all prefix C-u in org-mode TODO: how to bind C-u keys?
  ;; (local-set-key (kbd "C-u C-<return>") 'org-export-as-html)
  (local-set-key (kbd "C-<tab>") 'other-window)
  (local-set-key (kbd "C-<tab>") 'other-window)
  (local-set-key (kbd "C-S-<tab>") (lambda ()
                                     (interactive) (other-window -1))))
(add-hook 'org-mode-hook 'aj-org-mode-hook)

;; Custom
(setq org-adapt-indentation nil)
(setq org-startup-folded t)
(setq org-level-color-stars-only nil)
(setq org-fontify-emphasized-text t)
(setq org-log-done nil)
(setq org-export-htmlize-output-type 'css)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")
        (sequence "QUESTION(q)" "|" "ANSWERED(s)")
        (sequence "NO(n)" "|" "YES(s)")
        ))

(setq org-todo-keyword-faces
      '(("STARTED" . org-upcoming-deadline)
        ("WAITING" . org-upcoming-deadline)))

;; Hide leading stars face
(setq org-hide-leading-stars nil)
(custom-set-faces
 '(org-hide ((((background light)) (:foreground "dim gray"))
             (((background dark)) (:foreground "dim gray")))))
 
(setq org-directory "~/Documents/org")

;; MbileOrg
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull (expand-file-name (concat org-directory "/notes.org")))
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")


(setq org-default-notes-file "~/Documents/org/notes.org")
;;(setq remember-annotation-functions '(org-remember-annotation))
;;(setq remember-handler-functions '(org-remember-handler))
;;(add-hook 'remember-mode-hook 'org-remember-apply-template)

;; (set-variable 'org-export-html-style-include-default nil)

(setq org-export-html-postamble nil)
(set-variable 'org-export-html-style
              "<link rel=\"stylesheet\" type=\"text/css\" href=\"/Users/antonj/.emacs.d/resources/monterosa-org-css/org-mode.css\" />")

;; (defun process-file (file)
;;    "Read the contents of a file into a temp buffer and then do
;;  something there."
;;    (when (file-readable-p file)
;;      (with-temp-buffer
;;        (insert-file-contents file)
;;        (goto-char (point-min))
;;        (while (not (eobp))
;;        ;; do something here with buffer content
;;          (forward-line)))))

;; (set-variable 'org-export-html-style
;;               "<link rel=\"stylesheet\" type=\"text/css\">"
              
;;               ~/.emacs.d/org-mode.css
;;               "</link>")

(set-variable 'org-export-with-section-numbers nil)

;; Clocking
(setq org-clock-history-length 35)


(provide 'aj-org)
