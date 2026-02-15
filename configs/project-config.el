;; Projectile config

(use-package projectile
  :config
  (projectile-mode +1)
  (setq projectile-switch-project-action #'projectile-dired))

(provide 'project-config)
