;; Early init

;; Paths and custom file
(add-to-list 'load-path "~/.config/emacs/elisp/")
(setq custom-file "~/.config/emacs/.custom.el")
(load custom-file)


;; Interpreter performance
(setq max-lisp-eval-depth 3200) ; cope and seethe
(setq gc-cons-threshold #x40000000)
(setq read-process-output-max (* 1024 1024 4))

;; Suppress annoying warnings
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
