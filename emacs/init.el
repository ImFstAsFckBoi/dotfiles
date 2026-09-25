;;; init.el --- Emacs configuration. -*- lexical-binding: t; -*-


;;; Setup backup and save files
(setq backup-directory-alist '(("." . "~/.config/emacs/backups/")))
(setq auto-save-file-name-transforms  `((".*" "~/.config/emacs/saves/" t)))


;;; Package setup
(require 'package)
(require 'use-package)

;; Add MELPA package repo
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)


;;; Load PATH shell environment
(use-package exec-path-from-shell
  :ensure t
  :defer nil
  :config  (exec-path-from-shell-initialize))


;;; Basic Emacs setup

;; Disable unwanted UI elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(tab-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Enable wanted UI elements
(delete-selection-mode)
(pixel-scroll-precision-mode)
(minibuffer-depth-indicate-mode t)
(global-display-line-numbers-mode)


(recentf-mode)
(xterm-mouse-mode 1)
(electric-indent-mode -1)
(electric-pair-mode electric-quote-mode)

(setopt auto-window-vscroll nil)
(setopt scroll-step 1)
(setq-default tab-width 4)
(setopt help-window-select t)
(setopt vc-follow-symlinks t)
(setopt indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default truncate-lines -1)
(setopt inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setopt eval-expression-print-level nil)
(setopt eval-expression-print-length nil)
(setopt delete-by-moving-to-trash t)
(setopt enable-recursive-minibuffers t)
(setopt ring-bell-function 'ignore)
(setq minibuffer-prompt-properties
      '(read-only t intangible t cursor-intangible t face minibuffer-prompt))


(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)


;; Random package stuff
(use-package diminish :ensure t)

(use-package tab-line
  :defer nil
  :bind ("C-x t" . global-tab-line-mode)
  :config
  (global-tab-line-mode +1)
  (setq tab-line-separator " ")
  (setq tab-line-new-button-show nil
        tab-line-close-button-show nil))

(use-package ls-lisp
  :config (setopt ls-lisp-dirs-first t))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config (which-key-mode))

(use-package eros
  :ensure t
  :config (eros-mode 1))

(defun safe-load (f)
  "Load file F with error without interrupting configuration."
  (condition-case err
      (load-library (concat f))
    (error (warn "Error when loading feature %s: %s" f err))))

(defun load-feature (feat)
  "Load configuration feature FEAT."
  (let ((load-path (cons "~/.config/emacs/elisp/features/" load-path)))
    (safe-load (concat "feat-" feat))))

;; Load files
(safe-load "functions")
(safe-load "theme")
(safe-load "keybinds")
(safe-load "git")
(safe-load "modern-ui")
(safe-load "languages")
(safe-load "cfg-webjump")
(safe-load "cfg-org")
(safe-load "cfg-dired")


;;;  Include feature modules
(load-feature "mktemp")
(load-feature "tempo")
(load-feature "spellcheck")
(load-feature "corfu")
(load-feature "embark")
(load-feature "occult")
(load-feature "lsp")
(load-feature "debugger")
(load-feature "hiiii")
(load-feature "term")
