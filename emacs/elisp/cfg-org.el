;;; org-mode configs

(use-package org
  :ensure t
  :hook (org-mode . org-indent-mode)
  
  :config
  (setopt org-support-shift-select t)
  (setf (alist-get 'file org-link-frame-setup) #'find-file)
  (setq org-latex-preview-mode-display-live t)
  (setq org-latex-preview-mode-update-delay 0.25)
  (plist-put org-format-latex-options :scale 1.5)
  (setq org-preview-latex-image-directory "~/.cache/ltximg/"))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode))

(use-package mixed-pitch
  :ensure t
  :hook (org-mode . mixed-pitch-mode))

(defun org-roam-node-linked-at-point ()
  "If point is on an `id:' link, return the linked org-roam node."
  (let ((elem (org-element-context)))
    (when (eq (org-element-type elem) 'link)
      (let ((type (org-element-property :type elem))
            (path (org-element-property :path elem)))
        (when (string= type "id")
          (org-roam-node-from-id path))))))

(defun org-roam-find-backlinks ()
  "Find nodes linking to a target, resolved in order:
1. id-link at point
2. active region (prefilled into node-read)
3. plain node-read prompt"
  (interactive)
  (let* ((target
          (or (org-roam-node-linked-at-point)
              (if (use-region-p)
                  (let ((initial (buffer-substring-no-properties
                                  (region-beginning) (region-end))))
                    (deactivate-mark)
                    (org-roam-node-read initial nil nil t "Node: "))
                (org-roam-node-read nil nil nil t "Node: ")))))
    (unless target
      (user-error "No target node selected"))
    (let ((backlink-ids
           (mapcar (lambda (bl)
                     (org-roam-node-id (org-roam-backlink-source-node bl)))
                   (org-roam-backlinks-get target))))
      (if backlink-ids
          (org-roam-node-visit
           (org-roam-node-read
            nil
            (lambda (node) (member (org-roam-node-id node) backlink-ids))
            nil t "Backlink: "))
        (message "No nodes link to \"%s\"" (org-roam-node-title target))))))


(use-package org-roam
  :ensure t
  :bind (:map org-mode-map (("M-." . org-open-at-point)
                            ("M-," . org-mark-ring-goto)
                            ("M-?" . org-roam-find-backlinks)
                            ("C-c C-c" . org-roam-db-sync)
                            ("C-x f" . #'org-roam-node-find)))
  :config
  (setq org-roam-directory "~/org/roam/")
  (org-roam-db-autosync-mode))

(use-package org-ref
  :ensure t
  :config
  (setq bibtex-completion-bibliography '("~/org/roam/refrences.bib")
        bibtex-completion-library-path '("~/Zotero/storage")
        bibtex-completion-notes-path "~/org/roam/"))

(use-package org-roam-bibtex
  :ensure t
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq orb-note-actions-interface 'default
        orb-preformat-keywords
        '("citekey" "title" "url" "author-or-editor" "keywords" "file")
        orb-templates
        '(("r" "ref" plain "%?"
           :target
           (file+head "%(orb-process-file-field \"${citekey}\")-${citekey}.org"
                      "#+title: ${title}\n#+created: %U\n#+last_modified: %U\n\n")
           :unnarrowed t))))


