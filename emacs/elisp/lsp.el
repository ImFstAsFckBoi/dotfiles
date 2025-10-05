;;; lsp.el --- eglot and eldoc setup

;; eglot-lsp and dape-dap stuff

(use-package eglot
  :ensure t
  :bind ("<f2>" . eglot-rename))

(use-package consult-eglot
  :ensure t
  :after (consult eglot)
  :bind ("C-O" . consult-eglot-symbols)
  :config (defalias 'symbols 'consult-eglot-symbols "Search workspace symbols"))


(add-hook 'eglot-managed-mode-hook #'imenu-add-menubar-index)
(setq imenu-auto-rescan t)

(when (executable-find "emacs-lsp-booster")
  (use-package eglot-booster
    :ensure t
    :vc (:url "https://github.com/jdtsmith/eglot-booster")
    :after  eglot
    :config (eglot-booster-mode)))

;;; lsp.el ends here
