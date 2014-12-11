(set-variable 'ns-pop-up-frames nil)
(setq trash-directory (expand-file-name "~/.Trash"))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
;;(setq mac-option-modifier 'alt)

(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen)
                           nil
                         'fullboth)))

(defun mac-open-current-visited-file ()
  "Open current visited file in standard osx program"
  (interactive)
  (if buffer-file-name
    (shell-command (concat "open " buffer-file-name))
    (message "Not visiting a file")))

;; Aquaemacs prevent opening new frames
(when (boundp 'aquamacs-version)
  (progn
    (one-buffer-one-frame-mode 0)
    ;; Prevent buffers to be opened in new frame
    (setq special-display-regexps nil)
    (tabbar-mode -1)))

(provide 'aj-mac)
