;; Early init

;; Paths and custom file
(add-to-list 'load-path "~/.config/emacs/elisp/")
(setq custom-file "~/.config/emacs/.custom.el")
(load custom-file)


;;; Interpreter performance

;; Set higher limits
(setq max-lisp-eval-depth 3200) ; cope and seethe
(setq gc-cons-threshold (* 1024 1024 1024)) ; 1 GiB
(setq read-process-output-max (* 1024 1024 4)) ; 4 MiB

;; Disable right-to-left optimizations
(setq bidi-display-reordering 'left-to-right
      bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Stop fontification when typing
(setq redisplay-skip-fontification-on-input t)


;; Suppress annoying warnings
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
