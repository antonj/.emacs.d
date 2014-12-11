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

;; (featurep 'auto-install)
;; (not (fboundp 'zenburn))
;; Autoloaded functions are not features
;; Autoloaded functions are bound

;;;; From help-fns.el
;; (defun help-function-arglist (def)
;;   ;; Handle symbols aliased to other symbols.
;;   (if (and (symbolp def) (fboundp def)) (setq def (indirect-function def)))
;;   ;; If definition is a macro, find the function inside it.
;;   (if (eq (car-safe def) 'macro) (setq def (cdr def)))
;;   (cond
;;    ((byte-code-function-p def) (aref def 0))
;;    ((eq (car-safe def) 'lambda) (nth 1 def))
;;    ((and (eq (car-safe def) 'autoload) (not (eq (nth 4 def) 'keymap)))
;;     "[Arg list not available until function definition is loaded.]")
;;    (t t)))

(setq aj-auto-load-installs
      '((:mode color-theme-blackboard
               :autoload t
               :url "https://github.com/technomancy/emacs-starter-kit/raw/master/elpa-to-submit/blackboard.el"
               :after (progn (message "================ blackboard after loaded")))
        (:mode auto-install
               :url "http://www.emacswiki.org/emacs/download/auto-install.el"
               :after (progn (message "================ after auto-install")
                             (autopair-global-mode t)
                             (setq autopair-autowrap t)))
        (:mode autopair
               :url "http://autopair.googlecode.com/svn/tags/REL_0_3/autopair.el"
               :after (progn (message "================ after autopair")))
        (:mode babel
               :url "https://github.com/juergenhoetzel/babel/raw/STABLE/babel.el"
               :after (progn (message (format "================ after babel Babel is loaded %s, it is a function %s"
                                              (locate-library "babel") (functionp 'babel)))))))

;; Load/Install auto-install packages
(mapc (lambda (mode-plist)
        (let* ((mode (plist-get  mode-plist :mode))
               (mode-url (plist-get mode-plist :url))
               (mode-after-load (plist-get mode-plist :after))
               (mode-autoloadp (plist-get mode-plist :autoload))
               ;; TODO: Will not always work. E.g. Google Code URL:s
               (mode-file-name (car (last (split-string mode-url "/")))))
          (message (format "Looking for %s, %s from %s" mode mode-file-name
                         mode-url))
          ;; TODO: Is fboundp ok? Global namespace collisions?
          (when (and (not (featurep mode)) (not (fboundp mode))) ;; Fucntion is not a feature and not bound, load or install
            (if (locate-library mode-file-name)
                (progn ;; Local file exist autoload it ;; TODO optional require
                  (message (format "Found library %s in %s" mode mode-file-name))
                  (if mode-autoloadp
                      (progn
                        (message "Autoloaded library %s" mode)
                        (autoload mode mode-file-name (concat "AJ-autoload " mode-file-name) t))
                    (progn
                      (message "Required library %s" mode)
                      (require mode))))
              (progn ;; Local file do not exist, install it
                (message (format "Did not find library %s in %s auto-installing it from %s"
                               mode mode-file-name mode-url))
                (auto-install-from-url mode-url))))
          ;; Optional eval after load settings
          (when mode-after-load
            (message (format "Adding eval-after load of %s" mode))
            ;; After autoload? mode-file-name, after require mode?
            (eval-after-load mode mode-after-load))))
      aj-auto-load-installs)