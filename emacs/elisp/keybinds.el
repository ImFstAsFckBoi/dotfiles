;; General keybinds



(global-set-key (kbd "C-x z") 'suspend-frame)
(global-set-key (kbd "C-x m") 'switch-to-minibuffer)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "C-r") 'repeat)
(global-set-key (kbd "C-x a") 'mark-whole-buffer)
(global-set-key (kbd "C-x C-.") 'emoji-search)
(global-set-key (kbd "C-x C-,") 'emoji-insert)
(global-set-key (kbd "C-p") #'search-backward)
(global-set-key (kbd "C-n") #'search-forward)

;; Make sure functions is loaded
(load-library "functions")
(global-set-key (kbd "C-x C-x") 'rotate)
(global-set-key (kbd "C-x f") 'find-file-dwim)
(global-set-key (kbd "C-<tab>") 'outline-toggle-entry)


;; My own arrow keys
(global-set-key (kbd "M-i") (mimic-global-key "<up>" nil t))
(global-set-key (kbd "M-k") (mimic-global-key "<down>" nil t))
(global-set-key (kbd "M-j") (mimic-global-key "<left>" nil t))
(global-set-key (kbd "M-l") (mimic-global-key "<right>" nil t))


;;; Unset annoying keybinds
(defun disabled-message () (interactive) (message "Key disabled!"))

(global-set-key (kbd "<mouse-2>") 'disabled-message)
(global-set-key (kbd "<mouse-3>") 'disabled-message)
(global-set-key (kbd "<insert>") 'disabled-message)
(global-set-key (kbd "C-q") 'disabled-messag)

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

(use-package multiple-cursors
  :ensure t
  :bind (("M-S-<up>" . 'mc/mark-previous-lines)
         ("M-S-<down>" . 'mc/mark-next-lines)
         :map mc/keymap
         ("C-n" . #'mc--search-forward--repeat-patched)
         ("C-p" . #'mc--search-backward--repeat-patched))
  :config
  (mc-def-repeat-patch search-forward)
  (mc-def-repeat-patch search-backward)
  (keymap-unset mc/keymap "<return>"))
