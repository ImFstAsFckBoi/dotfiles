;; Some custom functions -*- lexical-binding: t; -*-

(defun msgwall (msg n)
  "Open a buffer with a wall of repeating phrase"
  (interactive "sMessage: \nnLines: ")
  (switch-to-buffer "msgwall")
  (erase-buffer)
  (dotimes (_ n) (insert (concat msg " "))))


;; cat Makefile | perl -n -E 'say $1 if /^([^\.^%^\s][^%^\s]*):( [^%^\s]*)?/gm'

(use-package imake
  :ensure t
  :config (defalias 'make 'imake))


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
  (if (eq (count-windows) 2)
      (let ((buffer (window-buffer (next-window)))
            (mknew (if (is-on-top) '(split-window-right) '(split-window-below))))
        (delete-other-windows)
        (eval mknew)
        (set-window-buffer (next-window) buffer))
    (message "Only works with 2 windows!")))


(defun all-config-files ()
  (append (file-expand-wildcards (concat user-emacs-directory "*.el"))
          (file-expand-wildcards (concat user-emacs-directory "elisp/*.el"))))

(defun find-config ()
  "Open Emacs configurations files"
  (interactive)
  (find-file
   (concat user-emacs-directory 
           (completing-read
            "Open config file: "
            (mapcar
             (lambda (path) (string-remove-prefix user-emacs-directory path))
             (all-config-files))))))

(defun find-file-dwim ()
  "Find recent files or project files"
  (interactive)
  (if (project-current)
      (call-interactively 'project-find-file)
    (call-interactively 'consult-recent-file)))

(defun outline-toggle-entry ()
  "Toggle show/hide outline entry"
  (interactive)
  (if (eq (outline--cycle-state) 'hide-all)
      (outline-show-entry)
    (outline-hide-entry)))

(defun mimic-global-key (key &optional map static)
  ""
  (let ((key (kbd key))
        (map (or map global-map)))
    (if static
        (lookup-key map key)
      (lambda () (interactive)
        (call-interactively (lookup-key map key))))))


(defmacro mc-def-repeat-patch (function)
  (let ((f-name (intern (format "mc--%s--repeat-patched" function))))
    `(defun ,f-name ()
       (interactive)
       (call-interactively ',function)
       (let ((last-repeatable-command ',function))
         (mc/execute-command-for-all-fake-cursors
          #'repeat)))))
