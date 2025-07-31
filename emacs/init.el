;; Emacs config


;; Setup backup and save files
(setq backup-directory-alist '(("." . "~/.config/emacs/backups/")))
(setq auto-save-file-name-transforms  `((".*" "~/.config/emacs/saves/" t)))

;; Package setup
(use-package package
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize))



(defun include-config (file)
  "Load ELisp config file from config directory"
  (condition-case err
      (load-file (expand-file-name (concat file ".el") (concat user-emacs-directory "elisp")))
    (error (message "Error loading %s: %s" file err))))


;; Basic Emacs setup
(recentf-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tab-bar-mode -1)
(scroll-bar-mode -1)
(xterm-mouse-mode 1)
(blink-cursor-mode -1)
(pixel-scroll-precision-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(electric-pair-mode electric-quote-mode)
(global-display-line-numbers-mode)
(electric-indent-mode -1)
(delete-selection-mode)

(setq-default tab-width 4)
(setq-default truncate-lines -1)
(setq-default indent-tabs-mode nil)
(setopt indent-tabs-mode nil)
(setopt scroll-step 1)
(setopt inhibit-startup-message t)


;; Load PATH env var
(use-package exec-path-from-shell
  :ensure t
  :config  (exec-path-from-shell-initialize))


;; Basic packages
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config (which-key-mode))

(use-package diminish :ensure t)

(use-package kkp
  :if (not (display-graphic-p))
  :ensure t
  :config (global-kkp-mode +1))

(use-package xclip
  :ensure t
  :config (xclip-mode))

(use-package eros
  :ensure t
  :config (eros-mode 1))

;; Load files
(include-config "theme")
(include-config "functions")
(include-config "keybinds")
(include-config "spellcheck")
(include-config "tempo")
(include-config "webjump-cfg")

;; setup language specifics
(include-config "languages")

;; modern ui
(include-config "corfu-cfg")
(include-config "consult-cfg")
(include-config "embark-cfg")

;; eglot eldoc and dape
(include-config "lsp")
(include-config "debugger")

;; homescreen
(include-config "hiiii")  ; ✨ hiiii! :3
