(defun aj-eclim-ido-complete()
  (interactive)
  (let* ((completion-list (mapcar 'eclim--completion-candidate-doc (eclim/java-complete)))
         (common (try-completion "" completion-list)))
    (if completion-list
        (let ((choise (ido-completing-read "> "
                                           completion-list
                                           nil
                                           nil
                                           common))
              (method)
              (str-insert))
          ;; Chop of return info from doc string to get stuff to insert
          (setq str-insert (car (split-string  choise " : ")))

          ;; Remove possible duplicates of from str-insert that might
          ;; already be written in buffer
          (aj-del-backwards-match-beginning str-insert)
          (if (string-match "(.+)" choise) ;; Method with params
              (progn
                ;; Create yasnippet pattern
                (setq method (replace-regexp-in-string
                              ")" "})"
                              (replace-regexp-in-string
                               ", " "}, ${"
                               (replace-regexp-in-string
                                "(" "(${" str-insert))))
                (yas/expand-snippet method (point) (point)))
            ;; not a method
            (insert str-insert))
          (message "No completions at this point")))))

(defun aj-del-backwards-match-beginning (str)
  "Deletes backwards from point matching chars at start of `str`.
Example: \"String.val[point]\" <= del-backwards-match-beinnign
\"values\" would delete val and."
  (save-excursion
    (let ((start-point (point))
          (result-start)
          (pos))
      (setq result-start
            (car
             (reverse
              (mapcar '(lambda (c)
                         (print c)
                         (setq pos (search-backward (string c) (1- (point)) t))
                         (when pos
                           (goto-char pos))
                         pos)
                      (reverse (string-to-list str))))))
      (when result-start
        (delete-region result-start start-point)))))
;;val  String.va     val
;;  this.   ;; br_high
;; "valueOf(double value)"
;; "valueOf(int value)"
;;  valu

(provide 'aj-eclim)
;; ;; Get common start
;; (try-completion "" (mapcar 'eclim--completion-candidate-doc aj-example-br))


;; ;; Example
;; (setq aj-example-br
;;       '(("v" "br_best" "br_best : int - ActiveDyad" "")
;;         ("v" "br_high" "br_high : int - ActiveDyad" "")
;;         ("v" "br_low" "br_low : int - ActiveDyad" "")))

;; (setq aj-example
;;       '(("v" "br_best" "br_best : int - ActiveDyad" "")
;;         ("v" "br_high" "br_high : int - ActiveDyad" "")
;;         ("v" "br_low" "br_low : int - ActiveDyad" "")
;;         ("v" "intensity" "intensity : double - ActiveDyad" "")
;;         ("v" "intensityDesc" "intensityDesc : String - ActiveDyad" "")
;;         ("v" "primaryIndexA" "primaryIndexA : int - ActiveDyad" "")
;;         ("v" "primaryIndexB" "primaryIndexB : int - ActiveDyad" "")
;;         ("v" "year" "year : int - ActiveDyad" "")
;;         ("v" "ywpForSideA" "ywpForSideA : List<se.uppsala.ucdp.model.YWP> - ActiveDyad" "")
;;         ("v" "ywpForSideB" "ywpForSideB : List<se.uppsala.ucdp.model.YWP> - ActiveDyad" "")
;;         ("f" "addYWPForSide(" "addYWPForSide(Side side, YWP ywp) : boolean - ActiveDyad" "")
;;         ("f" "clone()" "clone() : Object - Object" "")))
