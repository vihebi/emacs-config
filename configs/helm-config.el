;; helm-config.el - buffer/file management replacing list-buffers

(use-package helm
  :config
  (helm-mode 1)
  ;; nicer helm window at bottom, like a popup
  (setq helm-split-window-in-side-p t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t))

(use-package helm-projectile
  :after (helm projectile)
  :config
  (helm-projectile-on))

(provide 'helm-config)
