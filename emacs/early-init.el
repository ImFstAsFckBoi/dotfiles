;; Early init. -*- lexical-binding: t; -*-

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


;;; Native compilation performance
;; gcc -march=native -Q --help=target | grep -oe "^\s*-march=\s*\\([^ ]*\\)" | grep -oe "[^ ]*$"


(let ((output (shell-command-to-string
               "gcc -march=native -Q --help=target | grep -e '^\s*-march=' | awk '{print $2}'")))
  (setq cpu-architecture (string-trim output)))

(setq native-comp-compiler-options `(;; The most meaningful optimizations:
                                     "-O2"
                                     ,(format "-mtune=%s" cpu-architecture)
                                     ,(format "-march=%s" cpu-architecture)
                                     ;; Reduce .eln size and compilation
                                     ;; overhead.
                                     "-g0"
                                     ;; Good defensive choice for Emacs
                                     ;; stability.
                                     "-fno-finite-math-only"))

(setq native-comp-driver-options '(;; -Wl,-z,pack-relative-relocs compresses
                                   ;; relocation tables to reduce file size and
                                   ;; slightly improve load times.
                                   "-Wl,-z,pack-relative-relocs"
                                   ;; -Wl,-O2 applies standard linker-level
                                   ;; optimizations (like string merging) to the
                                   ;; generated shared object.
                                   "-Wl,-O2"
                                   ;; -Wl,--as-needed prevents the linker from
                                   ;; recording dependencies on libraries that
                                   ;; are not actually used by the code.
                                   "-Wl,--as-needed"))

;;; Suppress annoying warnings
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)

