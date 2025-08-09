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
  "Load ELisp config file from elsip directory"
  (condition-case err
      (load-file (expand-file-name (concat file ".el") (concat user-emacs-directory "elisp")))
    (error (warn "Error loading %s: %s" file err))))


;; Basic Emacs setup
(recentf-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tab-bar-mode -1)
(scroll-bar-mode -1)
(xterm-mouse-mode 1)
(blink-cursor-mode -1)
(delete-selection-mode)
(electric-indent-mode -1)
(pixel-scroll-precision-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(global-display-line-numbers-mode)
(electric-pair-mode electric-quote-mode)

(setq-default tab-width 4)
(setq-default truncate-lines -1)
(setq-default indent-tabs-mode nil)
(setopt indent-tabs-mode nil)
(setopt scroll-step 1)
(setopt inhibit-startup-message t)
(setopt delete-by-moving-to-trash t)
(setopt vc-follow-symlinks t)


;; Load PATH env var
(use-package exec-path-from-shell
  :ensure t
  :config  (exec-path-from-shell-initialize))


;; Random package stuff
(use-package diminish :ensure t)

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config (which-key-mode))


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

(use-package dired-x
  :bind (:map dired-mode-map ("C-f" . dired-x-find-file)))


;; Load files
(include-config "functions")
(include-config "theme")
(include-config "keybinds")
(include-config "spellcheck")
(include-config "tempo")
(include-config "git")


;; misc package configs
(include-config "corfu-cfg")
(include-config "consult-cfg")
(include-config "embark-cfg")
(include-config "webjump-cfg")
(include-config "org-cfg")


;; lsp debugger and language configs
(include-config "languages")
(include-config "lsp")
(include-config "debugger")

;; homescreen
(include-config "hiiii")  ; ✨ hiiii! :3

