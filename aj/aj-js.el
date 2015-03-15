;; Add "support" for js files in speedbar, interpreted as c
;; (speedbar-add-supported-extension ".js")
;; (add-to-list 'speedbar-fetch-etags-parse-list
;;              '("\\.js" . speedbar-parse-c-or-c++tag))

(setq js2-mirror-mode nil)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(defun aj-js-compr-buffer()
  (interactive)
  ;; Change yui compr to fit your path
  (let ((yui-compr-jar (expand-file-name "~/lib/yuicompressor-2.4.2/build/yuicompressor-2.4.2.jar")))
  (shell-command
   (concat "java -jar " yui-compr-jar 
           " -o " (first (split-string (buffer-file-name)
                                       "[.]js")) ".min.js"
                                       " "(buffer-file-name)))))

;; From: http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode
(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        ;; (if (looking-at "case\\s-")
        ;;     (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))
      
      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-js2-mode-hook ()
  (define-key js2-mode-map [(meta q)] 'c-fill-paragraph)
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(meta j)] 'hippie-expand)
  (setq js2-basic-offset 2)


  ;; npm install -g tern
  ;; M-x package-install tern
  ;; M-x package-install tern-auto-complete
  (tern-mode t)
  (eval-after-load 'tern
    '(progn
       (tern-ac-setup)))
)

(add-hook 'js2-mode-hook 'my-js2-mode-hook)
(provide 'aj-js)
