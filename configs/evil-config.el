;; Evil config

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)

  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
  
  (define-key evil-normal-state-map (kbd "g c") 'comment-dwim)
  (define-key evil-visual-state-map (kbd "g c") 'comment-dwim)

  (define-key evil-normal-state-map (kbd "C-b") 'dired-jump)
  (define-key evil-visual-state-map (kbd "C-b") 'dired-jump))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Leader key
(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ;; Files
    "ff" 'find-file
    "fs" 'save-buffer

    ;; Buffers
    "bb" 'switch-to-buffer
    "bk" 'kill-buffer

    ;; Bookmarks
    "rl" 'bookmark-bmenu-list
    ;; "rb" 'bookmark-jump
    "rb" (lambda ()
           (interactive)
           (bookmark-jump
            (ido-completing-read "Jump to bookmark: " (bookmark-all-names))))

    ;; Projects (tmux-like workspace switching)
    "pp" 'projectile-switch-project      ; switch project (like tmux C-b s)
    "pf" 'projectile-find-file           ; find file in project
    "pb" 'projectile-switch-to-buffer    ; switch buffer within project
    "pk" 'projectile-kill-buffers        ; kill all project buffers
    "pr" 'projectile-recentf             ; recent files in project

    ;; Code
    "ca" 'eglot-code-actions
    "vrn" 'eglot-rename
    "cd" 'xref-find-definitions
    "cD" 'xref-find-references

    ;; Documentation and diagnostics
    "k"  'eldoc-doc-buffer
    "vd" 'flymake-show-buffer-diagnostics
    "vn" 'flymake-goto-next-error
    "vp" 'flymake-goto-prev-error))

(provide 'evil-config)
