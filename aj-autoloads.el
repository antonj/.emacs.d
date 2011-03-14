;; (functionp 'auto-install)
;; (find-library 'js2-mode)
;; (locate-library (symbol-name 'babel))
;; (locate-library (symbol-name 'js2))
;; (locate-library "js2-mode")
;; (find-library "js2-mode") ;; Autoloaded libraries cant be found?
;; (fboundp 'js2-mode)

;; (plist-get '(:hej "hallå" :aj "anton") "hej")

;; (setq anton (progn (message "================ after auto-install")))
;; (eval-after-load "babel" anton)

(setq aj-auto-load-installs
      '((:mode auto-install :url "http://www.emacswiki.org/emacs/download/auto-install.el" :after
               (progn (message "================ after auto-install")))
        (:mode autopair :url "http://autopair.googlecode.com/svn/tags/REL_0_3/autopair.el" :after
               (progn (message "================ after autopair")))
        (:mode babel :url "https://github.com/juergenhoetzel/babel/raw/STABLE/babel.el" :after
               (progn (message "================ after babel")
                      (message (format "Babel is loaded %s, it is a function %s"
                                       (locate-library "babel") (functionp 'babel)))))))

;; Load/Install auto-install packages
(mapc (lambda (mode-plist)
        (let* ((mode (plist-get  mode-plist :mode))
               (mode-url (plist-get mode-plist :url))
               (mode-after-load (plist-get mode-plist :after))
               ;; TODO: Will not always work
               (mode-file-name (car (last (split-string mode-url "/")))))
          (print (format "Looking for %s, %s from %s, after %s" mode mode-file-name
                         mode-url mode-after-load))
          (when (not (fboundp mode)) ;; Fucntion do not exits, load or install
            (if (locate-library mode-file-name)
                (progn ;; Local file exist autoload it ;; TODO optional require
                  (print (format "Found library %s in %s autoloading it" mode mode-file-name))
                  (autoload mode mode-file-name))
              (progn ;; Local file do not exist, install it
                (print (format "Did not find library %s in %s auto-installing it from %s"
                               mode mode-file-name mode-url))
                (auto-install-from-url mode-url))))
          ;; Optional eval after load settings
          (when mode-after-load
            (eval-after-load mode mode-after-load))))
      aj-auto-load-installs)
