;; Consult and Vertico, etc setup

(use-package consult
  :ensure t
  :bind
  ("C-x b" . consult-buffer)
  ("C-x p g" . consult-ripgrep)
  ("C-:" . :)
  ("C-s" . save-buffer)
  ("C-f" . consult-line-dwim)
  :config

  (defun consult-line-dwim ()
    (interactive)
    (consult-line (if (not (region-active-p)) ""
                    (buffer-substring-no-properties (region-beginning) (region-end)))))

  (defalias 'errors 'consult-flymake "Search flymake errors")
  (defalias ': 'consult-goto-line "Goto Line number")
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))


(use-package vertico
  :ensure t
  :config (vertico-mode)
  (vertico-multiform-mode))

(use-package savehist
  :config (savehist-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(basic
                       partial-completion
                       orderless
                       flex)))

(use-package marginalia
  :ensure t
  :config (marginalia-mode))


(use-package consult-eglot
  :ensure t
  :after (consult eglot)
  :bind ("C-O" . consult-eglot-symbols)
  :config (defalias 'symbols 'consult-eglot-symbols "Search workspace symbols"))
