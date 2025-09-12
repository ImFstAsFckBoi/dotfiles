;; eglot-lsp and dape-dap stuff

(use-package eldoc-box
  :ensure t
  :diminish eldoc-box-hover-at-point-mode
  :hook (eldoc-mode . (lambda ()
                        (if (display-graphic-p)
                            (eldoc-box-hover-at-point-mode)))))

(use-package eglot
  :ensure t
  :bind ("<f2>" . eglot-rename)
  :hook ( eglot-mode . sideline-mode)
  :config (with-eval-after-load 'typst-ts-mode
            (add-to-list 'eglot-server-programs
                         `((typst-ts-mode) .
                           ,(eglot-alternatives `(,typst-ts-lsp-download-path
                                                  "tinymist"
                                                  "typst-lsp"))))))


(add-hook 'eglot-managed-mode-hook #'imenu-add-menubar-index)
(setq imenu-auto-rescan t)

(when (executable-find "emacs-lsp-booster")
  (use-package eglot-booster
    :ensure t
    :vc (:url "https://github.com/jdtsmith/eglot-booster")
    :after  eglot
    :config (eglot-booster-mode)))
