;;; Theme, font & looks

(use-package all-the-icons :ensure t)


(use-package adwaita-dark-theme
  :ensure t
  :config
  (load-theme 'adwaita-dark t)
  (eval-after-load 'diff-hl #'adwaita-dark-theme-diff-hl-fringe-bmp-enable)
  (eval-after-load 'flymake #'adwaita-dark-theme-flymake-fringe-bmp-enable)
  (adwaita-dark-theme-arrow-fringe-bmp-enable))


;;;; Custom elbox-doc setup
(eval-after-load 'eldoc-box '(set-face-attribute 'eldoc-box-body nil :background "gray19"))
(eval-after-load 'eldoc-box '(set-face-attribute 'eldoc-box-border nil :background "gray19"))
(eval-after-load 'eldoc-box '(set-face-attribute 'eldoc-box-border nil :height 140))

(set-face-attribute 'default nil :height 140)
(set-face-attribute 'mode-line-buffer-id nil :foreground "#ffbcd8")

(add-to-list 'default-frame-alist `(font . "Adwaita Mono"))
(set-fontset-font t #x1F5BF (font-spec :family "Noto Sans Symbols 2") nil 'prepend)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (add-to-list 'default-frame-alist `(font . "monospace"))
;; (add-to-list 'default-frame-alist `(font . "ComicShannsMono Nerd Font Mono"))
;; (add-to-list 'default-frame-alist `(font . "Iosevka Nerd Font"))


;;;; Render whitespace
(global-whitespace-mode 1)
(diminish 'global-whitespace-mode)
(diminish 'whitespace-mode)

(setq-default whitespace-style
              '(face spaces tabs newline space-mark tab-mark newline-mark))

;; Set display styles for space (center dot) tab (|->)
(setq whitespace-display-mappings
      '((space-mark   ?\     [?\u00B7] [?.])
        (tab-mark     ?\t    [?\u21E5 ?\t] [?\u00BB ?\t] [?\\ ?\t])))

                                        ; set foreground (characters) to light gray
(set-face-attribute 'whitespace-space nil :foreground "#52494e" :background nil)
(set-face-attribute 'whitespace-tab nil :foreground "#52494e" :background nil)


;; Other appearance packages
(use-package mood-line
  :ensure t
  ;; Enable mood-line
  :config (mood-line-mode)

  ;; Use pretty Fira Code-compatible glyphs
  :custom
  (mood-line-glyph-alist mood-line-glyphs-fira-code)
  (mood-line-show-eol-style t)
  (mood-line-format mood-line-format-default-extended))

(use-package golden-ratio
  :ensure t
  :diminish golden-ratio-mode
  :config (golden-ratio-mode 1))

(use-package solaire-mode
  :ensure t
  :config (solaire-global-mode +1))

(use-package rainbow-delimiters
  :ensure t
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))

(use-package indent-guide
  :ensure t
  :config (indent-guide-global-mode))


