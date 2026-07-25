;; Projectile config

(use-package projectile
  :config
  (projectile-mode +1)
  (setq projectile-globally-ignored-directories
      '(".git" "node_modules" "target" ".cache" ".clangd"))
  (setq projectile-enable-caching 'persistent)
  (setq projectile-switch-project-action #'projectile-dired))

(provide 'project-config)
