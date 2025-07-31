;;; language-modes
(unless (version<= emacs-version "29.0")
  (use-package treesit-auto
    :ensure t
    :config (treesit-auto-add-to-auto-mode-alist 'all)
    (global-treesit-auto-mode))

  (add-hook 'c-ts-mode-hook 'setup-hide-ifdef)
  (add-hook 'c++-ts-mode 'setup-hide-ifdef))

;; (use-package "flex")       ; (f)lex scanner generator language mode
;; (use-package "bison-mode") ; bison / yacc parser generator language mode

(defun setup-hide-ifdef ()
  (hide-ifdef-mode t)
  (hide-ifdef-toggle-shadowing)
  (hide-ifdefs))


(use-package markdown-mode
  :ensure t
  :config (setq markdown-command "cmark"))

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

