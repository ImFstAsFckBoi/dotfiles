;; Jinx spellcheck

;; Make sure spellchecker is installed
(when (executable-find "enchant-2")
  (use-package jinx
    :ensure t
    :demand t
    :diminish jinx-mode
    :config (global-jinx-mode)))
