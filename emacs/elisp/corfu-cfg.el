;;; Corfu -*- lexical-binding: t -*-

(use-package corfu
  :ensure t
  :bind (:map corfu-map ("RET" . corfu--mc--insert))
  :custom (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-quit-at-boundary 'separator)
  (corfu-echo-documentation 0.1)
  :config
  (global-corfu-mode)
  (corfu-history-mode)


  (defun corfu--mc--insert-impl ()
    (let* ((prefix-len (cdr corfu--input))
           (cand (nth corfu--index corfu--candidates))
           (suffix (substring cand prefix-len nil)))
      (corfu-quit)
      (mc/execute-command-for-all-cursors
       (lambda () (interactive) (insert suffix)))))

  (defun corfu--mc--insert ()
    (interactive)
    (if (not multiple-cursors-mode)
        (call-interactively #'corfu-insert)
      (corfu--mc--insert-impl)))

  )

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
