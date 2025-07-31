;; Dape debugger


(use-package dape
  :ensure t
  :hook (kill-emacs . dape-breakpoint-save)
  (after-init . dape-breakpoint-load)
  :bind
  ("C-x C-a <down>" . dape-next)
  ("C-x C-a <right>" . dape-step-in)
  ("C-x C-a <left>" . dape-step-out)
  :config
  (setq dape-inlay-hints t)
  (add-hook 'dape-display-source-hook 'pulse-momentary-highlight-one-line))
