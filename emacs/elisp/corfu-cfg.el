;;; Corfu
(use-package corfu
  :ensure t
  :custom (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-quit-at-boundary 'separator)
  (corfu-echo-documentation 0.1)
  :config (global-corfu-mode)
  (corfu-history-mode))

(use-package corfu-popupinfo
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil)
  :config (corfu-popupinfo-mode))

(use-package corfu-terminal
  :if (not (display-graphic-p))
  :after corfu
  :ensure t
  :config  (corfu-terminal-mode))

(use-package kind-icon
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))
