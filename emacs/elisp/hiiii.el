(defun get-string-from-file (file-path)
  "Return the entire contents of FILE-PATH as a string."
  (with-temp-buffer
    (insert-file-contents file-path)
    (buffer-string)))

(setq-default hiiii-page-file (expand-file-name "hiiii-page.el" user-emacs-directory))

(load "hiiii-commands.el")

(setq initial-scratch-message
      (get-string-from-file hiiii-page-file))

(setq initial-major-mode 'org-mode)
