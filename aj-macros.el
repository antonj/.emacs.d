(fset 'aj-start-four-shells
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 49 134217848 115 104 101 108 108 return 24 50 21 134217848 115 104 101 108 108 return return 24 50 21 134217848 115 104 101 108 108 return return 24 50 21 134217848 115 104 101 108 108 return return 24 43 C-tab] 0 "%d")) arg)))

;; Wille make list of
;; int id;
;; String country_name;
;; Into cursor get statements
(fset 'aj-sqlite-to-java-cursor-get
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([116 104 105 115 46 134217828 4 19 59 2 32 61 32 99 46 103 101 116 25 134217826 6 6 6 134217827 40 99 46 103 101 116 67 111 108 117 109 110 73 110 100 101 120 40 134217837 134217830 6 67108896 19 32 2 134217847 19 105 110 100 101 120 6 34 25 14 134217837] 0 "%d")) arg)))

(fset 'json-pretty-region
   [?\C-u ?\M-\" ?j ?s ?o ?n backspace backspace backspace backspace ?p ?y ?t ?h ?o ?n ?  ?- ?m ?j ?s ?o ?n ?. ?t ?o ?o ?l return])

(provide 'aj-macros)
