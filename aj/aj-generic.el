;;; package -- Generic stuff
;;; Commentary:
;; Time-stamp: "2021-09-02 18:34:43 antonj"
;;; Code:

(global-subword-mode t)
(global-auto-revert-mode t)
(set-variable 'inhibit-startup-message t)
(set-variable 'user-mail-address "anton\.johansson@gmail\.com")
(set-variable 'user-full-name "Anton Johansson")
(set-default 'truncate-lines t)
(setq delete-by-moving-to-trash t)
(setq transient-mark-mode t)
(global-font-lock-mode t)
(show-paren-mode t)
(setq-default indicate-empty-lines t)
(setq fill-column 80)
(column-number-mode t)
(setq visible-bell nil) ;; The default
(setq ring-bell-function 'ignore) ;; Prevent el capitan visible bell bugg
(setq-default indent-tabs-mode nil)  ;; TAB ger mellanslag
(setq tab-width 3)                   ;; Emacs 23: set tabs to 3 spaces
(set-face-background (quote cursor) "red")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(setq sentence-end-double-space nil)
(setq dabbrev-abbrev-skip-leading-regexp "[^ ]*[<>=*]") ;; skip <tags> when expanding
(eval-after-load "grep"
  '(progn
     (add-to-list 'grep-find-ignored-files "*.min.js")
     (add-to-list 'grep-find-ignored-directories "node_modules")))
;; (add-to-list 'same-window-regexps '("^\*"))

(setq same-window-regexps nil);;'(("^*")))
(add-to-list 'same-window-buffer-names "*Help*")
(add-to-list 'same-window-buffer-names "*shell*")
(add-to-list 'same-window-buffer-names "*Apropos*")
(add-to-list 'same-window-buffer-names "*Summary*")
(add-to-list 'same-window-buffer-names "*grep*")
(setq pop-up-windows t)
(setq pop-up-frames nil)
(setq split-height-threshold 1000)
(setq split-width-threshold 1000)
(delete-selection-mode t)
(setq whitespace-style '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark))

;; perf
(setq gc-cons-threshold 150000000)
(setq read-process-output-max (* 2 1024 1024)) ;; 2mb


;; Spelling
;; $ brew install aspell --lang=sv,en
;; TODO: is `ispell-program-name' used? Not defined and documented
(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))


;; LINUM
(global-linum-mode)
(defun linum-on ()
  "* When linum is running globally, disable line number in modes defined in `linum-disabled-modes-list'. Changed by linum-off. Also turns off numbering in starred modes like *scratch*"
  (unless (or (minibufferp)
              (member major-mode '(eshell-mode wl-summary-mode compilation-mode org-mode text-mode dired-mode doc-view-mode image-mode))
              (string-match "*" (buffer-name))
              (> (buffer-size) 3000000)) ;; disable linum on buffer greater than 3MB, otherwise it's unbearably slow
    (linum-mode 1)))


;; Coding system
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(fset 'yes-or-no-p 'y-or-n-p)

;; Set PATH and exec-path from echo PATH

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(defun chomp (str)
  "Chomp leading and tailing whitespace from STR."
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'"
                       str)
    (setq str (replace-match "" t t str)))
  str)

(cd "~/") ;; Make sure we are in home dir
(let* ((path-prefix "PATH{")
       (echo-env (concat "$SHELL --login -i -c 'echo " path-prefix "$PATH'"))
       (shell-output (shell-command-to-string echo-env))
       (path-from-shell
        (split-string
         (substring shell-output
                    (+ (length path-prefix)
                       (string-match path-prefix
                                     shell-output)))
         path-separator)))

  (setq path-from-shell (delete-dups (append (mapcar 'chomp path-from-shell) exec-path)))
  (setenv "PATH" (mapconcat 'identity path-from-shell path-separator))
  (setq exec-path path-from-shell))

(set-variable 'vc-path '("/usr/local/bin"))

;; Mouse-scroll amount
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control))))

;; Frame-title shows filename
(setq frame-title-format '(multiple-frames "%b" "%b"))

;; Skeletons
;; (global-set-key "'" 'skeleton-pair-insert-maybe)
;; (global-set-key "\"" 'skeleton-pair-insert-maybe)
;; (global-set-key "[" 'skeleton-pair-insert-maybe)
;; (global-set-key "(" 'skeleton-pair-insert-maybe)
;; (global-set-key "{" 'skeleton-pair-insert-maybe)
;; (set-variable 'skeleton-pair t)

;; Keybindings
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x C-<up>") 'windmove-up)

(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x C-<down>") 'windmove-down)

(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x C-<right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x C-<left>") 'windmove-left)

(global-set-key "\M-1" 'beginning-of-buffer)
(global-set-key "\M-2" 'end-of-buffer)
(global-set-key (kbd "C-M-SPC") 'anything)
(global-set-key (kbd "C-M--") 'shrink-window)
(global-set-key (kbd "C-M-_") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-+") 'enlarge-window)
(global-set-key (kbd "C-M-?") 'enlarge-window-horizontally)
(global-set-key "\M-n" 'just-one-space)
(global-set-key "\M-p" 'mark-paragraph)
(global-set-key "\M-j" 'hippie-expand)  ;dabbrev-expand)

(setq hippie-expand-dabbrev-as-symbol t)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev-visible
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-file-name-partially
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        ))

(global-set-key "\C-w" 'backward-kill-word) ;; erases standard kill-region
(global-set-key "\C-x\C-k" 'kill-region) ;; replace standard kill-region
;; (global-set-key "\M-y" 'anything-show-kill-ring) ;; replace standard yank-pop
(global-set-key (kbd "C-x C-b") 'ibuffer) ;; removes standard list-buffers
(global-set-key "\C-co" 'ffap)
(global-set-key "\C-cp" 'mac-open-current-visited-file)
;; Open file with osx open shell command
(global-set-key "\C-cO" (lambda() (interactive)
                          (shell-command
                           (concat "open " (buffer-file-name)))))
(global-set-key "\C-x\C-m" 'execute-extended-command) ;; M-x
(global-set-key "\C-c\C-m" 'execute-extended-command) ;; M-x
(global-set-key "\C-xm" 'magit-status)
(global-set-key "\C-cm" 'magit-status)
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key "\C-xO" (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-S-<tab>") (lambda () (interactive) (other-window -1)))
(global-set-key "\C-o" (lambda() (interactive)
                         (save-excursion (newline-and-indent))
                         (indent-according-to-mode)))
(global-set-key (kbd "C-7") 'indent-region)
(global-set-key (kbd "M-8") 'comment-region)
(global-set-key (kbd "C-8") 'comment-region)
(global-set-key (kbd "C-9") 'uncomment-region)
(global-set-key (kbd "M-9") 'uncomment-region)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
;;(global-set-key (kbd "C-u C-s") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "C-M-r") 'isearch-forward-symbol-at-point)

(define-key occur-mode-map (kbd "C-x C-q") 'occur-edit-mode)
(define-key occur-edit-mode-map (kbd "C-x C-q") 'occur-cease-edit)

(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))

(global-set-key (kbd "M-s") 'neotree-project-dir)
(global-set-key [f5]   'call-last-kbd-macro) ;; bind key for calling last macro
(global-set-key "\M-\"" 'shell-command-on-region)

;; Alias
(defalias 'qrr 'query-replace-regexp)
(defalias 'mkdir 'make-directory)
(defun ls()
  (interactive)
  (shell-command "ls"))

;; GDB
(setq gdb-many-windows t)

;; Autosaves ;;;;;;;;;;;;;;;;;;;;
;; Put autosave files (ie #foo#) in one place, *not* scattered all over the
;; file system! (The make-autosave-file-name function is invoked to determine
;; the filename of an autosave file.)
;; (defvar autosave-dir "~/.emacs.d/autosave")
;; (make-directory autosave-dir t)

;; (defun auto-save-file-name-p (filename)
;;   (string-match "^#.*#$" (file-name-nondirectory filename)))

;; (defun make-auto-save-file-name ()
;;   (concat autosave-dir
;;           (if buffer-file-name
;;               (concat "/#" (file-name-nondirectory buffer-file-name) "#")
;;             (expand-file-name
;;              (concat "#%" (buffer-name) "#")))))

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "~/.emacs.d/autosave/backup"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Style ;;;;;;;;;;;;;;;;;;;;;;;;;
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(when window-system
;;  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(defun current-line-empty-p ()
  "Return t if line contain other things than whitespace, nil otherwise."
  (interactive)
  (= 0 (string-match-p "^\\s-*$" (thing-at-point 'line))))

(defun uuid ()
  "Insert an UUID."
  (interactive)
  (insert (shell-command-to-string "printf %s \"$(uuidgen)\"")))

(defun aj-indent-relative()
  "Indent relative to line above no matter where on the line your are"
  (interactive)
  (if (current-line-empty-p)
      (progn
        (move-beginning-of-line 1)
        (just-one-space)
        (backward-delete-char 1)
        (indent-relative t))
    (save-excursion
      (move-beginning-of-line 1)
      (just-one-space)
      (backward-delete-char 1)
      (indent-relative t))))

;; Functions
(defun point-indentation ()
  "Get point at first char of line."
  (save-excursion
    (back-to-indentation)
    (point)))

(defun aj-back-to-line-or-indentation ()
  "Go to beginning of line or back to indentation."
  (interactive)
  (if (equal (point) (point-indentation))
      (beginning-of-line)
    (back-to-indentation)))
(global-set-key (kbd "C-a") 'aj-back-to-line-or-indentation)

(defun insert-date-time()
  "Inserts standard date time string."
  (interactive)
  (insert (format-time-string "%c")))

(defun indent-whole-buffer()
  "indent whole buffer"
  (interactive)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (delete-trailing-whitespace))
(defalias 'iwb 'indent-whole-buffer)

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "*sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "*DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn
        (copy-file filename newname 1)
        (delete-file filename)
        (set-visited-file-name newname)
        (set-buffer-modified-p nil)
        t))))

(defun tidy-buffer ()
  "Run Tidy HTML parser on current buffer."
  (interactive)
  (if (get-buffer "tidy-errs") (kill-buffer "tidy-errs"))
  (shell-command-on-region (point-min) (point-max)
                           "tidy -f /tmp/tidy-errs -q -i -utf8 -asxhtml -wrap 0 -c" t)
  (find-file-other-window "/tmp/tidy-errs")
  (other-window 1)
  (delete-file "/tmp/tidy-errs")
  (message "buffer tidy'ed"))

(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" (buffer-substring beg end))))

;; Open all existing files read-only
;; (defun aj-find-file-hook()
;;   (toggle-read-only t))
;; (add-hook 'find-file-hook 'aj-find-file-hook)

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;; Hooks ;;;;;;;;;;;;;;;;;;;;;;;;
;; Timestamp
(add-hook 'before-save-hook 'time-stamp) ;; insert time-stamp before saves

;; From sean @ http://emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/
;; (add-hook 'after-save-hook 'aj-recompile-el)
;; (defun aj-recompile-el ()
;;   (interactive)
;;   (when (and buffer-file-name
;;              (string-match "/.*\\.el$"  buffer-file-name)
;;              (file-newer-than-file-p buffer-file-name
;;                                      (concat buffer-file-name "c"))
;;              (y-or-n-p (format "byte-compile %s? "
;;                                (file-name-nondirectory (buffer-file-name)))))
;;     (byte-compile-file buffer-file-name)))

;; Log-edit
(add-hook 'log-edit-mode-hook 'flyspell-mode)

;; Folding

(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (set-selective-display
   (if selective-display nil
     (or (save-excursion
           (back-to-indentation) (+ 1 (current-column))) 1))))
(global-set-key [(M C i)] 'aj-toggle-fold)

(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (local-set-key [(M C i)] 'aj-toggle-fold)))

(add-hook 'nxml-mode-hook
          (lambda()
            (local-set-key [(M C i)] 'aj-toggle-fold)))

;;(defvar markdown-mode-map)
;;(add-hook 'mardown-mode-hook
;;          (progn
;;            (define-key markdown-mode-map [(M C i)] 'aj-toggle-fold)))


(defun sticky-buffer-window ()
  "Toggle whether this window is dedicated to this buffer. From
http://www.reddit.com/r/emacs/comments/gjqki/is_there_any_way_to_tell_emacs_to_not/"
  (interactive)
  (set-window-dedicated-p
   (selected-window)
   (not (window-dedicated-p (selected-window))))
  (if (window-dedicated-p (selected-window))
      (message "Window is now dedicated.")
    (message "Window is no longer dedicated.")))

;; logview mode from http://stackoverflow.com/questions/133821/the-best-tail-gui
(defvar angry-fruit-salad-log-view-mode-map
  (make-sparse-keymap))

(define-minor-mode angry-fruit-salad-log-view-mode
  "View logs with colors.

Angry colors."
  nil " AngryLog" nil

  (cond (angry-fruit-salad-log-view-mode
         (auto-revert-tail-mode 1)
         (highlight-changes-mode 1)
         (define-key angry-fruit-salad-log-view-mode-map
           (kbd "C-c C-r")
           'highlight-changes-rotate-faces)
         (if (current-local-map)
             (set-keymap-parent angry-fruit-salad-log-view-mode-map
                                (current-local-map)))
         ;; set the keymap
         (use-local-map angry-fruit-salad-log-view-mode-map))

        (t
         (auto-revert-tail-mode -1)
         (highlight-changes-mode -1)
         (use-local-map (keymap-parent angry-fruit-salad-log-view-mode-map)))))

;; CUA rectangle edits
;; (setq cua-enable-cua-keys nil) ;; only for rectangles
;; (cua-mode t)

;; by Nikolaj Schumacher, 2008-10-20. Licensed under GPL.
(defun semnav-up (arg)
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (decf arg))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (incf arg)))
  (up-list arg))

(defun extend-selection (arg &optional incremental)
  "Mark the symbol surrounding point.
Subsequent calls mark higher levels of sexps."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (or (and transient-mark-mode mark-active)
                         (eq last-command this-command))))
  (if incremental
      (progn
        (semnav-up (- arg))
        (forward-sexp)
        (mark-sexp -1))
    (if (> arg 1)
        (extend-selection (1- arg) t)
      (if (looking-at "\\=\\(\\s_\\|\\sw\\)*\\_>")
          (goto-char (match-end 0))
        (unless (memq (char-before) '(?\) ?\"))
          (forward-sexp)))
      (mark-sexp -1))))

(global-set-key "\M-p" 'extend-selection)


(defun aj-dired-ediff-marked-files ()
  (interactive)
  (apply 'ediff-files `(,@(dired-get-marked-files))))


(provide 'aj-generic)
