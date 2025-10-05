;;; language-modes and related stuff
(use-package treesit-auto
  :ensure t
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package pyvenv-auto
  :ensure t
  :hook ((python-mode . pyvenv-auto-run)
         (python-ts-mode . pyvenv-auto-run)))

(use-package flymake-collection
  :ensure t
  :hook ((flymake-diagnostic-functions . flymake-collection-flake8)))

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1)
  (setf (alist-get 'python-ts-mode apheleia-mode-alist)
        '(black isort)))


;; prog/text mode hooks

(add-hook 'prog-mode-hook 'eldoc-mode)
(add-hook 'prog-mode-hook 'flymake-mode)

(add-hook 'text-mode-hook (lambda ()
                            (toggle-truncate-lines nil)
                            (toggle-word-wrap t)))



;; Language modes

;; (use-package "bison-mode") ; bison / yacc parser generator language mode
;; (use-package "flex")       ; (f)lex scanner generator language mode

(use-package markdown-mode
  :ensure t
  :bind (:map markdown-mode-map (("C-c C-<up>" . markdown-outline-previous)
                                 ("C-c C-<down>" . markdown-outline-next)))
  :config (when (executable-find "cmark") (setq markdown-command "cmark")))


(use-package typst-ts-mode
  :custom (typst-ts-mode-watch-options "--open")
  :hook ((typst-ts-mode . (lambda () (run-hooks 'prog-mode-hook)))))

(use-package typst-ts-mode
  :after eglot
  :config  (add-to-list 'eglot-server-programs
                        `((typst-ts-mode) .
                          ,(eglot-alternatives `(,typst-ts-lsp-download-path
                                                 "tinymist")))))


;; DONT WORK!
;;(use-package websocket :ensure t)
;; (use-package typst-preview
;;   :ensure t
;;   :after typst-ts-mode
;;   :vc (:url "https://github.com/havarddj/typst-preview.el")
;;   :custom (typst-preview-browser "xwidget")
;;   :bind (:map typst-preview-mode-map (("C-c C-j" . typst-preview-send-position))))

(defun setup-hide-ifdef ()
  (hide-ifdef-mode t)
  (hide-ifdef-toggle-shadowing)
  (hide-ifdefs))

(add-hook 'c-ts-mode-hook #'setup-hide-ifdef)
(add-hook 'c++-ts-mode-hook #'setup-hide-ifdef)


;;; languages.el ends here
