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

(defun vihebi/projectile-last-buffer ()
  "Jump to the most recently used file buffer of the project being switched to.
Falls back to `projectile-find-file' for projects not visited this session."
  (let* ((root (projectile-project-root))
         (buf  (seq-find (lambda (b)
                           (and (buffer-file-name b)
                                (projectile-project-buffer-p b root)))
                         (buffer-list))))
    (if buf
        (switch-to-buffer buf)
      (projectile-find-file))))

(setq projectile-switch-project-action #'vihebi/projectile-last-buffer)

(provide 'helm-config)
