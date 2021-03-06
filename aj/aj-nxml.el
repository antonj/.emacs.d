(setq nxml-child-indent 2)
(setq nxml-slash-auto-complete-flag t)

;; svn co http://whattf.svn.cvsdude.com/syntax/trunk/relaxng/ ~/.emacs.d/resources/schemas/html5
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files
                "~/.emacs.d/resources/schemas/schemas.xml"))

(setq mumamo-background-colors nil)

(put 'http://whattf.org/datatype-draft
     'rng-dt-compile
     'whattf-dt-compile)
(defun whattf-dt-compile (name params) (list t 'identity))

(defun aj-nxml-mode-hook ()
  (local-set-key (kbd "C-<return>") 'complete-symbol)
  (if (string= "build.xml" (buffer-name))
      (local-set-key (kbd "C-<return>") 'jde-build))
  (toggle-truncate-lines 1))
(add-hook 'nxml-mode-hook 'aj-nxml-mode-hook)

(provide 'aj-nxml)
