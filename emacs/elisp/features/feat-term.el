;;; term.el --- Terminal support. -*- lexical-binding: t; -*-

(use-package kkp
  :if (not (display-graphic-p))
  :ensure t
  :config (global-kkp-mode +1))

(use-package xclip
  :ensure t
  :config (xclip-mode))
