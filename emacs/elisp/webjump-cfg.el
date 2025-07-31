;; webjump

;; (use-package "webjump"
;;   :ensure t
;;   :bind ("C-x w j" . webjump)
;;   ;;   :config

;;   ;;   (defun webjump-ida-course-page (_)
;;   ;;     (format "https://www.ida.liu.se/~%s/" (upcase (read-string "Course code: "))))

;;   ;;   (add-to-list 'webjump-sites '("IDA course page" . webjump-ida-course-page))
;;   ;;   (add-to-list 'webjump-sites '("Hoogλe" . [simple-query 
;;   ;;                                             "https://hoogle.haskell.org/"
;;   ;;                                             "https://hoogle.haskell.org/?hoogle="
;;   ;;                                             ""]))
;;   ;;   (add-to-list 'webjump-sites '("Python docs" .
;;   ;;                                 [simple-query 
;;   ;;                                  "https://docs.python.org/"
;;   ;;                                  "https://docs.python.org/3/search.html?q="
;;   ;;                                  ""]))
;;   )

(use-package webjump)

(defun webjump-ida-course-page (_)
  (format "https://www.ida.liu.se/~%s/" (upcase (read-string "Course code: "))))

(setq webjump-sites nil)
(add-to-list 'webjump-sites '("IDA course page" . webjump-ida-course-page))
(add-to-list 'webjump-sites '("Hoogλe" . [simple-query 
                                          "https://hoogle.haskell.org/"
                                          "https://hoogle.haskell.org/?hoogle="
                                          ""]))
(add-to-list 'webjump-sites '("Python docs" .
                              [simple-query 
                               "https://docs.python.org/"
                               "https://docs.python.org/3/search.html?q="
                               ""]))
