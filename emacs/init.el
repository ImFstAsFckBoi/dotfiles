;; Emacs config


;; Setup backup and save files
(setq backup-directory-alist '(("." . "~/.config/emacs/backups/")))
(setq auto-save-file-name-transforms  `((".*" "~/.config/emacs/saves/" t)))

;; Package setup
(use-package package
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize))



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
(global-display-line-numbers-mode)
(minibuffer-depth-indicate-mode t)
(electric-pair-mode electric-quote-mode)

(setopt scroll-step 1)
(setq-default tab-width 4)
(setopt help-window-select t)
(setopt vc-follow-symlinks t)
(setopt indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default truncate-lines -1)
(setopt inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setopt delete-by-moving-to-trash t)
(setopt enable-recursive-minibuffers t)


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


(defun safe-load (lib)
  (condition-case err
      (load-library lib)
    (error (warn "Error when loading %s: %s" lib err))))



;; Load files
(safe-load "mktemp")
(safe-load "functions")
(safe-load "theme")
(safe-load "keybinds")
(safe-load "spellcheck")
(safe-load "tempo")
(safe-load "git")


;; misc package configs
(safe-load "corfu-cfg")
(safe-load "consult-cfg")
(safe-load "embark-cfg")
(safe-load "webjump-cfg")
(safe-load "org-cfg")


;; lsp debugger and language configs
(safe-load "languages")
(safe-load "lsp")
(safe-load "debugger")

;; homescreen
(safe-load "hiiii")  ; ✨ hiiii! :3

