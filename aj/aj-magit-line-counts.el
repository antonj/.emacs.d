(defvar aj-magit--diff-line-counts nil)
(defvar aj-magit--line-count-mode nil)

(defun aj-magit--normalize-numstat-file (file)
  (cond
   ((string-match "{.* => \\(.*\\)}" file)
    (replace-match (match-string 1 file) nil t file))
   ((string-match " => " file)
    (substring file (match-end 0)))
   (t file)))

(defun aj-magit--count-patch-lines (lines)
  (let ((added 0)
        (removed 0))
    (dolist (line lines)
      (cond
       ((or (string-prefix-p "+++" line)
            (string-prefix-p "---" line)
            (string-prefix-p "@@" line)) nil)
       ((string-prefix-p "+" line)
        (setq added (1+ added)))
       ((string-prefix-p "-" line)
        (setq removed (1+ removed)))))
    (cons added removed)))

(defun aj-magit--read-file-line-counts (file)
  (let* ((args (append (and (eq aj-magit--line-count-mode 'staged)
                            '("--cached"))
                       '("--no-prefix" "--unified=0")
                       (seq-remove (lambda (arg)
                                     (member arg '("--stat" "--numstat")))
                                   magit-buffer-diff-args)
                       (list "--" file)))
         (lines (apply #'magit-git-lines "diff" args)))
    (when lines
      (aj-magit--count-patch-lines lines))))

(defun aj-magit--get-file-line-counts (file)
  (or (cdr (assoc file aj-magit--diff-line-counts))
      (let ((counts (aj-magit--read-file-line-counts file)))
        (when counts
          (push (cons file counts) aj-magit--diff-line-counts))
        counts)))

(defun aj-magit--line-count-suffix (file)
  (when-let ((counts (aj-magit--get-file-line-counts file)))
    (concat
     (propertize "  (" 'face 'shadow)
     (propertize (format "+%s" (or (car counts) 0))
                 'font-lock-face 'magit-diffstat-added)
     (propertize " " 'face 'shadow)
     (propertize (format "-%s" (or (cdr counts) 0))
                 'font-lock-face 'magit-diffstat-removed)
     (propertize ")" 'face 'shadow))))

(defun aj-magit--sum-line-counts (files)
  (let ((added 0)
        (removed 0))
    (dolist (file files)
      (when-let ((counts (aj-magit--get-file-line-counts file)))
        (setq added (+ added (or (car counts) 0)))
        (setq removed (+ removed (or (cdr counts) 0)))))
    (cons added removed)))

(defun aj-magit--header-line-count-suffix (files)
  (when-let ((counts (aj-magit--sum-line-counts files)))
    (concat
     " "
     (propertize "(" 'face 'shadow)
     (propertize (format "+%s" (or (car counts) 0))
                 'font-lock-face 'magit-diffstat-added)
     (propertize " " 'face 'shadow)
     (propertize (format "-%s" (or (cdr counts) 0))
                 'font-lock-face 'magit-diffstat-removed)
     (propertize ")" 'face 'shadow))))

(defun aj-magit--section-heading (title)
  (propertize title 'face 'magit-section-heading))

(defun aj-magit--section-count (count)
  (propertize (format " (%s)" count)
              'font-lock-face 'magit-section-child-count))

(defun aj-magit-format-file-with-line-counts (kind file face &optional status orig)
  (concat (magit-format-file-default kind file face status orig)
          (if (eq kind 'diff)
              (or (aj-magit--line-count-suffix file)
                  (and orig (aj-magit--line-count-suffix orig))
                  "")
            "")))

(defun aj-magit-insert-unstaged-changes-with-line-counts ()
  (let* ((aj-magit--diff-line-counts nil)
         (aj-magit--line-count-mode 'unstaged)
         (files (magit-unstaged-files nil magit-buffer-diff-files)))
    (magit-insert-section (unstaged)
      (magit-insert-heading
        (aj-magit--section-heading "Unstaged changes")
        (aj-magit--section-count (length files))
        (aj-magit--header-line-count-suffix files))
      (magit--insert-diff nil
        "diff" magit-buffer-diff-args "--no-prefix"
        "--" magit-buffer-diff-files))))

(defun aj-magit-insert-staged-changes-with-line-counts ()
  ;; Avoid listing all files as deleted when visiting a bare repo.
  (unless (magit-bare-repo-p)
    (let* ((aj-magit--diff-line-counts nil)
           (aj-magit--line-count-mode 'staged)
           (files (magit-staged-files nil magit-buffer-diff-files)))
      (magit-insert-section (staged)
        (magit-insert-heading
          (aj-magit--section-heading "Staged changes")
          (aj-magit--section-count (length files))
          (aj-magit--header-line-count-suffix files))
        (magit--insert-diff nil
          "diff" "--cached" magit-buffer-diff-args "--no-prefix"
          "--" magit-buffer-diff-files)))))

(advice-add 'magit-insert-unstaged-changes :override
            #'aj-magit-insert-unstaged-changes-with-line-counts)
(advice-add 'magit-insert-staged-changes :override
            #'aj-magit-insert-staged-changes-with-line-counts)

(setq magit-format-file-function #'aj-magit-format-file-with-line-counts)

(provide 'aj-magit-line-counts)
