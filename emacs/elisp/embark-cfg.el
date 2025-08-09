;;; Embark


(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         ("C-," . embark-act-noquit)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings))

  :config  (defun embark-act-noquit ()
             "Run action but don't quit the minibuffer afterwards."
             (interactive)
             (let ((embark-quit-after-action nil))
               (embark-act)))

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  
  (defun embark-jinx-correct (_)
    "Correct spelling using jinx"
    (call-interactively 'jinx-correct))

  (defun embark-jinx-languages (_)
    "Set jinx's used language"
    (call-interactively 'jinx-languages))

  (defvar-keymap embark-jinx-map
    :doc "Keymap for jinx marked words."
    "n" #'jinx-next
    "p" #'jinx-previous
    "l" #'jinx-languages
    "RET" #'jinx-correct)


  (with-eval-after-load 'jinx
    (embark-define-overlay-target jinx category (eq %p 'jinx-overlay))
    (add-to-list 'embark-target-finders 'embark-target-jinx-at-point)
    (add-to-list 'embark-keymap-alist '(jinx . embark-jinx-map))
    (add-to-list 'embark-repeat-actions #'jinx-next)
    (add-to-list 'embark-repeat-actions #'jinx-previous)
    (keymap-set embark-general-map "$" 'embark-jinx-map)))

(use-package embark-consult
  :after (embark consult)
  :ensure t
  :demand t
  :hook (embark-collect-mode . consult-preview-at-point-mode))
