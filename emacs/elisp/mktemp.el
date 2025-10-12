

(setq mktemp--prog-lang-ext-alist '(("Text" . "txt")
                                    ("Json" . "json") ("Yaml" . "yaml") ("XML" . "xml")
                                    ("Markdown" . "md") ("Org" . "org") ("Typst" . "typ") ("LaTeX" . "tex")
                                    ("Bash" . "sh") ("Shell script" . "sh")
                                    ("C" . "c") ("C++" . "cc") ("C header" . "h") ("C++ header" . "hh")
                                    ("Javascript" . "js") ("Typescript" . "ts") ("HTML" . "html") ("CSS" . "css")
                                    ("Python" . "py") ("Cython" . "pyx")
                                    ("ELisp" . "el")
                                    ("Java" . "java")
                                    ("Ada specification" . "ads") ("Ada body" . "adb")
                                    ("C#" . "cs")
                                    ("Rust" . "rs")
                                    ("Go" . "go")
                                    ("Julia" . "jl")
                                    ("Common Lisp" . "cl")))


(defun mktemp--prog-lang-ext-annotate (cand)
  (let* ((ext (cdr (assoc cand mktemp--prog-lang-ext-alist)))
         (max-len (apply #'max (mapcar #'length (mapcar #'car mktemp--prog-lang-ext-alist))))
         (pad (- (+ max-len 1) (length cand))))
    (format "%s(%s)" (string-pad "" pad) ext)))


(defun mktemp--prog-lang-ext-completion-table (string pred action)
  (let ((candidates (mapcar #'car mktemp--prog-lang-ext-alist)))
    (cond ((eq action 'metadata) '(metadata (annotation-function . mktemp--prog-lang-ext-annotate)))
          (t (complete-with-action action candidates string pred)))))


(defun mktemp ()
  "Open a /tmp file in a new buffer"
  (interactive)
  (let ((suffix (cdr (assoc (completing-read
                             "Choose file type (default Text): "
                             #'mktemp--prog-lang-ext-completion-table
                             nil t nil nil "Text") mktemp--prog-lang-ext-alist))))
    (find-file (make-temp-file "" nil (concat "." suffix) ""))))


(defun mktemp-dir ()
  "Open a /tmp directory in a new buffer"
  (interactive)
  (find-file (make-temp-file "" t)))


(provide 'mktemp)
