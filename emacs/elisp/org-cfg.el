;;; org-mode configs

(use-package org
  :ensure t
  :hook (org-mode . org-indent-mode))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode))

(use-package mixed-pitch
  :ensure t
  :hook (org-mode . mixed-pitch-mode))
