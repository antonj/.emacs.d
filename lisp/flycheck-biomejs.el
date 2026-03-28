;;; flycheck-biomejs.el --- Flycheck: Biome JavaScript/TypeScript/CSS linter support -*- lexical-binding: t; -*-

;; Copyright (C) 2024  craneduck

;; Author: craneduck <28823828+craneduck@users.noreply.github.com>
;; Keywords: tools, convenience, javascript, typescript
;; Version: 0.1.2
;; Package-Requires: ((emacs "29.1") (flycheck "32"))

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This Flycheck extension is an EXPERIMENTAL PACKAGE intended to provide
;; JavaScript/TypeScript syntax checking by biome.
;; (see URL `https://biomejs.dev/')

;;; Code:

(require 'flycheck)

(defgroup flycheck-biomejs ()
  "."
  :group 'tools
  :prefix "flycheck-biomejs-"
  :link '(url-link "https://github.com/craneduck/flycheck-biomejs"))

(defun flycheck-biomejs/get-version (command)
  "Return biome version string.

COMMAND: Full path or command name of the biome command"
  ;; Version: 1.6.0 => "1.6.0"
  (let ((line (shell-command-to-string
               (mapconcat #'shell-quote-argument
                          `(,command "--version") " ")))
        (re (rx "Version:"
                (zero-or-more space)
                (group (one-or-more digit)
                       "."
                       (one-or-more digit)
                       "."
                       (one-or-more digit)))))
    (when (string-match-p re line)
      (string-match re line)
      (match-string 1 line))))

(defun flycheck-biomejs/check-version (installed supported)
  "Compare INSTALLED and SUPPORTED versions and return a boolean value."
  (let* ((installed (split-string installed "\\."))
         (supported (split-string supported "\\."))
         (installed-major (string-to-number (nth 0 installed)))
         (installed-minor (string-to-number (nth 1 installed)))
         (installed-patch (string-to-number (nth 2 installed)))
         (supported-major (string-to-number (nth 0 supported)))
         (supported-minor (string-to-number (nth 1 supported)))
         (supported-patch (string-to-number (nth 2 supported))))
    (cond ((< installed-major supported-major) nil)
          ((> installed-major supported-major) t)
          (t (cond ((< installed-minor supported-minor) nil)
                   ((> installed-minor supported-minor) t)
                   (t (>= installed-patch supported-patch)))))))

(defun flycheck-biomejs/get-config-path ()
  "Return biome.json or biome.jsonc path."
  (or (when-let ((path (locate-dominating-file buffer-file-name "biome.jsonc")))
        (expand-file-name "biome.jsonc" path))
      (when-let ((path (locate-dominating-file buffer-file-name "biome.json")))
        (expand-file-name "biome.json" path))))


(defun flycheck-biomejs/find-working-directory (_cehcker)
  "Return working directory path."
  (when buffer-file-name (or (locate-dominating-file buffer-file-name "biome.json")
                             (locate-dominating-file buffer-file-name "biome.jsonc")
                             (locate-dominating-file buffer-file-name "node_modules"))))

(defun flycheck-biomejs/remove-unstable-message (output)
  "Remove unstable message from OUTPUT."
  (let ((re (rx "The --json option is unstable/experimental and its output might change between patches/minor releases."
                (group (+? anychar))
                (or (group "lint " (>= 1 "━") anychar)
                    string-end))))
    (when (string-match-p re output)
      (string-match re output)
      (match-string 1 output))))

(defun flycheck-biomejs/parse-error (output checker buffer)
  "Convert biome diagnostic information to flycheck errors.

See `flycheck-define-checker' for the three arguments OUTPUT, CHECKER, and BUFFER"
  (let ((parsed (flycheck-parse-json (flycheck-biomejs/remove-unstable-message output))))
    (mapcar (lambda (diag)
              (let-alist diag
                (flycheck-error-new-at-pos
                 (1+ (car .location.span))
                 (pcase .severity
                   ((or "error" "fatal") 'error)
                   ((or "information" "hint") 'info)
                   ((or "warning" _) 'warning))
                 (format "%s(%s)" .description .category)
                 :end-pos (1+ (cadr .location.span))
                 ;;:id (cddr (split-string .category "/"))
                 :checker checker
                 :buffer buffer
                 :filename (buffer-file-name buffer))))
            (let-alist (car parsed) .diagnostics))))

(defun flycheck-biomejs/enabled ()
  "Run it only once to make sure the checker has everything it needs."
  (and buffer-file-name
       (let* ((command (executable-find "biome"))
              (version (when command (flycheck-biomejs/get-version command)))
              (version-p (when version (flycheck-biomejs/check-version version "1.9.0")))
              (config-path (flycheck-biomejs/get-config-path)))
         (and version-p config-path))))

(defun flycheck-biomejs/verify (_checker)
  "Verify flycheck-biomejs."
  (let* ((command (executable-find "biome"))
         (version (when command (flycheck-biomejs/get-version command)))
         (version-p (when version (flycheck-biomejs/check-version version "1.9.0")))
         (config-path (and buffer-file-name (flycheck-biomejs/get-config-path))))
    (list
     (flycheck-verification-result-new
      :label "biome command"
      :message (if command (format "Found at %s" command) "Not found")
      :face (if command 'success '(bold error)))
     (flycheck-verification-result-new
      :label "biome config file"
      :message (if config-path (format "Found at %s" config-path) "Not found")
      :face (if config-path 'success '(bold error)))
     (flycheck-verification-result-new
      :label "biome version"
      :message (if version-p (format "%s" version) (format "%S" version))
      :face (if version-p 'success '(bold error))))))

(flycheck-define-checker javascript-biome
  "A Javascript/TypeScript syntax and style checker using eslint.

See URL `https://biomejs.dev'."
  :command ("biome" "lint" "--reporter=json" source)
  :enabled flycheck-biomejs/enabled
  :error-parser flycheck-biomejs/parse-error
  :working-directory flycheck-biomejs/find-working-directory
  :modes (js-mode js2-mode js-ts-mode typescript-mode typescript-ts-mode typescript-tsx-mode css-mode)
  :verify flycheck-biomejs/verify)

(add-to-list 'flycheck-checkers 'javascript-biome)

(provide 'flycheck-biomejs)
;;; flycheck-biomejs.el ends here
