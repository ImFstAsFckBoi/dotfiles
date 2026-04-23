(use-package dired-x
  :after dired
  :bind (:map dired-mode-map ("C-f" . dired-x-find-file)))

(use-package dired-subtree
  :ensure t
  :after dired
  :custom ((dired-subtree-line-prefix "  =>  "))
  :bind (:map dired-mode-map ("TAB" . dired-subtree-toggle)))
