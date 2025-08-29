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
  :vc (:url "https://github.com/ImFstAsFckBoi/blamer.el" :rev :newest)
  :bind ("C-x v b" . #'blamer-show-posframe-commit-info)
  :custom ((blamer-idle-time 0.5)
           (blamer-type 'echo-area)
           (blamer-show-avatar-p t)
           (blamer-author-formatter "✎ %s ")
           (blamer-datetime-formatter "[%s] ")
           (blamer-echo-area-inset 3)
           (blamer-echo-area-strip-face-attributes '(:background :foreground))
           (blamer-max-commit-message-length (window-body-width (minibuffer-window))))
  :config (global-blamer-mode))
