;;; ephemeral-dired --- Dired buffer that disappear quickly. -*- lexical-binding: t; -*-

;;; Commentary:

(setq ephemeral-dired--ref-pass nil)

(defun ephemeral-dired-quit ()
  (interactive)
  (let* ((buf (current-buffer))
         (win (get-buffer-window buf)))
    (kill-buffer buf)
    (delete-window win)))

(defun ephemeral-dired-to-side ()
  "Jump to an ephemeral Dired buffer to right."
  (interactive)
  (split-window-right)
  (let* ((buf (current-buffer))
         (win (get-buffer-window buf))
         (dired-mode-hook (cons #'ephemeral-dired-mode dired-mode-hook)))
    (setq ephemeral-dired--ref-pass win)
    (dired-jump-other-window)
    ))

(defun ephemeral-dired-find-file-in-ref ()
  ""
  (interactive)
  (let* ((buf (current-buffer))
         (win (get-buffer-window buf))
         (ref ephemeral-dired--ref))
    (dired-find-file)
    (let ((new-buf (current-buffer)))
      (select-window ref)
      (kill-buffer buf)
      (set-window-buffer ref new-buf)
      (delete-window win))))

(define-minor-mode ephemeral-dired-mode
  "Dired buffers that disappear when you're not looking."
  :lighter " Ephemeral-Dired"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "RET") #'ephemeral-dired-find-file-in-ref)
            (define-key map (kbd "q") #'ephemeral-dired-quit)
            map)
  :global nil
  
  (setq-local ephemeral-dired--ref ephemeral-dired--ref-pass)
  (setq  ephemeral-dired--ref-pass nil))

(provide 'ephemeral-dired)
;;; ephemeral-dired.el ends here
