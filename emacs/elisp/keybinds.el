;; General keybinds



(global-set-key (kbd "C-x f") 'find-file-dwim)
(global-set-key (kbd "C-x z") 'suspend-frame)
(global-set-key (kbd "C-x m") 'switch-to-minibuffer)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "C-r") 'repeat)
(global-set-key (kbd "C-x a") 'mark-whole-buffer)
(global-set-key (kbd "C-x C-.") 'emoji-search)
(global-set-key (kbd "C-x C-,") 'emoji-insert)
(global-set-key (kbd "C-p") 'search-backward)
(global-set-key (kbd "C-n") 'search-forward)

;; Unset annoying keybinds
(global-unset-key (kbd "<mouse-2>"))
(global-unset-key (kbd "<mouse-3>"))
(global-unset-key (kbd "C-q"))

(when (daemonp)
  (global-set-key (kbd "C-x C-c") 'delete-frame))

(use-package beat+
  :ensure t
  :vc (:url "https://github.com/ImFstAsFckBoi/beatp")
  :bind
  ("C-w" . beatp-dwim-kill)
  ("M-w" . beatp-dwim-save)
  ("C-d" . beatp-select-around-word-or-next-match)
  ("C-<right>" . beatp-right-to-boundary)
  ("C-<left>" . beatp-left-to-boundary)
  ("C-<delete>" . beatp-delete-right-to-boundary)
  ("C-<backspace>" . beatp-delete-left-to-boundary)
  ("<up>" . beatp-dwim-previous-line))


(use-package "move-text"
  :ensure t
  :bind
  ("M-<down>" . move-text-down)
  ("M-<up>" . move-text-up))


(use-package "multiple-cursors"
  :ensure t
  :bind
  ("M-S-<up>" . 'mc/mark-previous-lines)
  ("M-S-<down>" . 'mc/mark-next-lines))

