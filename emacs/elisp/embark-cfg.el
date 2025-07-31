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
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :after (embark consult)
  :ensure t
  :demand t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package embark-jinx
  :after (embark jinx)
  :ensure t
  :bind(:map embark-symbol-map ("$" . embark-jinx)
             :map embark-general-map ("$" . embark-jinx)
             :map embark-region-map ("$" . embark-jinx))
  :vc (:url "https://github.com/ImFstAsFckBoi/embark-jinx"))
