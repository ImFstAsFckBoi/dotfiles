;; Some custom functions

(defun msgwall (msg n)
  "Open a buffer with a wall of repeating phrase"
  (interactive "sMessage: \nnLines: ")
  (switch-to-buffer "msgwall")
  (erase-buffer)
  (dotimes (_ n) (insert (concat msg " "))))

(defun mktemp ()
  "Open a /tmp file in a new buffer"
  (interactive)
  (find-file (string-trim (shell-command-to-string "mktemp"))))

;; cat Makefile | perl -n -E 'say $1 if /^([^\.^%^\s][^%^\s]*):( [^%^\s]*)?/gm'
(defalias 'make 'imake)

(defun insert-list-reverse (list)
  (if (not list) nil
    (delete-char 1)
    (insert-char (string-to-char (car list)))
    (left-char 2)
    (insert-list-reverse (cdr list))))

(defun reverse-chars-region (beg end)
  "Reverse the characters in a region"
  (interactive "r")
  (goto-char (- end 1))
  (insert-list-reverse (string-split (buffer-substring-no-properties beg end) "" t)))

(defun is-on-top ()
  (when (eq (count-windows) 2)
    (< (nth 1 (window-edges (selected-window))) (nth 1 (window-edges (next-window))))))

(defun rotate ()
  "Rotate two-window-setups between Left-Right split and Top-Bottom split"
  (interactive)
  (when (eq (count-windows) 2)
    (let ((buffer (window-buffer (next-window)))
          (mknew (if (is-on-top) '(split-window-right) '(split-window-below))))
      (delete-other-windows)
      (eval mknew)
      (set-window-buffer (next-window) buffer))))

(defun find-file-dwim ()
  "Find recent files or project files"
  (interactive)
  (if (project-current)
      (call-interactively 'project-find-file)
    (call-interactively 'consult-recent-file)))
