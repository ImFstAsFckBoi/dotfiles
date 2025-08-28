;; Git integrations


(use-package magit
  :ensure t)


(use-package diff-hl
  :ensure t
  :custom (diff-hl-draw-borders nil)
  :config
  (custom-set-faces
   '(diff-hl-change ((t (:background "#2b67b1"))))
   '(diff-hl-insert ((t (:background "#7ccd7c"))))
   '(diff-hl-delete ((t (:background "#ee6363")))))
  (global-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (diff-hl-flydiff-mode)
  (with-eval-after-load 'magit
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)))


(use-package blamer
  :ensure t
  :bind ("C-x v b" . (lambda () (interactive) (blamer-show-commit-info 'selected)))
  :custom ((blamer-author-formatter "✎ %s ")
           (blamer-datetime-formatter "[%s] ")))
