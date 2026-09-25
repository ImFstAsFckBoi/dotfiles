;;; . -*- lexical-binding: t; -*-

(add-hook 'dired-mode-hook 'dired-async-mode)


(use-package dired-x
  :after dired
  :bind (:map dired-mode-map ("C-f" . dired-x-find-file)))

(use-package dired-subtree
  :ensure t
  :after dired
  :custom ((dired-subtree-line-prefix "\t"))
  :bind (:map dired-mode-map ("TAB" . dired-subtree-toggle)))


(use-package casual
  :ensure t)

(use-package wdired
  :bind (:map dired-mode-map ("e" . #'wdired-change-to-wdired-mode)))

(use-package casual-dired
  :bind (:map dired-mode-map (("h" . casual-dired-tmenu)
                              ("s" . casual-dired-sort-by-tmenu)
                              ("/" . casual-dired-search-replace-tmenu)
                              ("C-c e" . casual-dired-elisp-tmenu)
                              ("C-c h" . dired-hide-details-mode)
                              ("C-c o" . dired-omit-mode))))

(use-package ephemeral-dired
  :bind ("C-x C-d" . ephemeral-dired-to-side))

;; (keymap-set dired-mode-map "M-o" #'dired-omit-mode)
;; (keymap-set dired-mode-map )
;; (keymap-set dired-mode-map "M-n" #'dired-next-dirline)
;; (keymap-set dired-mode-map "M-p" #'dired-prev-dirline)
;; (keymap-set dired-mode-map "]" #'dired-next-subdir)
;; (keymap-set dired-mode-map "[" #'dired-prev-subdir)
;; (keymap-set dired-mode-map "M-]" #'dired-next-marked-file)
;; (keymap-set dired-mode-map "M-[" #'dired-prev-marked-file)
;; (keymap-set dired-mode-map "A-M-<mouse-1>" #'browse-url-of-dired-file)
;; (keymap-set dired-mode-map "<backtab>" #'dired-prev-subdir)
;; (keymap-set dired-mode-map "TAB" #'dired-next-subdir)
;; (keymap-set dired-mode-map "M-j" #'dired-goto-subdir)
;; (keymap-set dired-mode-map ";" #'image-dired-dired-toggle-marked-thumbs)
