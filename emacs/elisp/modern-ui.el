;;; modern-ui.el ---  Consult and Vertico, etc setup

(use-package consult
  :ensure t
  :demand t
  :bind
  (("C-x b" . consult-buffer)
   ("C-x p g" . consult-ripgrep)
   ("C-:" . :)
   ("C-s" . save-buffer)
   ("C-f" . consult-line-dwim)
   ("C-x r l" . consult-bookmark))
  :config

  (defun consult-line-dwim ()
    (interactive)
    (consult-line (if (not (region-active-p)) ""
                    (buffer-substring-no-properties (region-beginning) (region-end)))))

  (defalias 'errors 'consult-flymake "Search flymake errors")
  (defalias ': 'consult-goto-line "Goto Line number"))


(use-package xref
  :after consult
  :custom ((xref-show-definitions-function #'consult-xref)
           (xref-show-xrefs-function #'consult-xref)))


(use-package vertico
  :ensure t
  :config
  (vertico-mode)
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



(use-package eldoc
  :demand t)

(use-package eldoc-box
  :after eldoc
  :ensure t
  :hook (eldoc-mode . (lambda ()
                        (when (display-graphic-p)
                          (eldoc-box-hover-at-point-mode 1)))))

(provide 'modern-ui)
;;; modern-ui.el ends here
