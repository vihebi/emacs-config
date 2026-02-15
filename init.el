;; Package setup
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; open Emacs at fullscreen at startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; not the best name for it, since the packages are downloaded there as well - not just configured
(add-to-list 'load-path "~/.emacs.d/configs")

(require 'org-config)
(require 'lsp-config)
(require 'evil-config)
(require 'project-config)
(require 'theme-config)
(require 'magit-config)

;; Basic settings
(setq display-line-numbers-type 'relative)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

(setq inhibit-startup-message t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(setq ring-bell-function 'ignore)

;; Custom global keybinding
(global-set-key (kbd "C-s") 'save-buffer)

;; ido mode
(require 'ido)
(ido-mode t)

;; Which-key
(setq which-key-idle-delay 0.5)
(which-key-mode 1)

;; Move backups to a separate dir
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)

;; Markdown images
(setq markdown-max-image-size '(800, 500))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(bookmark+ cargo cmake-mode company doom-modeline doom-themes
               evil-collection evil-leader magit projectile rust-mode
               treesit-auto)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
