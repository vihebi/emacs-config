;; evil-config.el   mirrors init.lua keybindings + LspAttach block

;; Evil core                                                                  
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
  (define-key evil-visual-state-map (kbd "C-b") 'dired-jump)

  (define-key evil-insert-state-map (kbd "C-f") 'apheleia-format-buffer)
  (define-key evil-normal-state-map (kbd "C-f") 'apheleia-format-buffer)
  (define-key evil-visual-state-map (kbd "C-f") 'apheleia-format-buffer)

  (defun my/evil-kill-magit ()
    (interactive)
    (if (bound-and-true-p with-editor-mode)
        (with-editor-cancel t)
      (kill-current-buffer)))

  (defun my/evil-save-kill-magit ()
    (interactive)
    (if (bound-and-true-p with-editor-mode)
        (with-editor-cancel t)
      (save-buffer)
      (kill-current-buffer)))

  (evil-ex-define-cmd "q" 'my/evil-kill-magit)
  (evil-ex-define-cmd "wq" 'my/evil-save-kill-magit)

  ;; (defun save-and-kill-this-buffer()(interactive)(save-buffer)(kill-current-buffer))
  ;; (evil-ex-define-cmd "wq" 'save-and-kill-this-buffer)
  ;; (evil-ex-define-cmd "q" 'kill-current-buffer)

  ;; Y yanks to end of line (mirrors your Y lambda)
  (define-key evil-normal-state-map (kbd "Y")
              (lambda ()
                (interactive)
                (evil-yank (point) (line-end-position)))))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;;  LSP keybindings (mirrors LspAttach block in init.lua)                      
;;
;;  nvim                          emacs
;;  gd                xref-find-definitions       (same as cd below, but on gd)
;;  <leader>vws       eglot-find-declaration      (workspace symbol search)
;;  <leader>vd        flymake-show-buffer-diagnostics (open float)
;;  <C-q>             eglot-code-actions
;;  <leader>vrr       xref-find-references
;;  <leader>vrn       eglot-rename
;;  <C-h> insert      eldoc-box-help-at-point      (signature help)
;;  [d                flymake-goto-next-error
;;  ]d                flymake-goto-prev-error
;;  <leader>k         eldoc-box-help-at-point      (hover with border)

(defun my/lsp-keybindings ()
  "Set LSP keybindings when eglot attaches. Mirrors init.lua LspAttach."
  ;; gd   go to definition (like vim.lsp.buf.definition)
  (evil-local-set-key 'normal (kbd "g d")
                      #'xref-find-definitions)

  ;; C-q   code actions (like vim.lsp.buf.code_action)
  (evil-local-set-key 'normal (kbd "C-q")
                      #'eglot-code-actions)

  ;; [d / ]d   next/prev diagnostic (note: nvim has these swapped vs flymake)
  ;; In your nvim config [d = goto_next, ]d = goto_prev   mirrored here
  (evil-local-set-key 'normal (kbd "[d")
                      #'flymake-goto-next-error)
  (evil-local-set-key 'normal (kbd "]d")
                      #'flymake-goto-prev-error)

  ;; C-h in insert   signature help (like vim.lsp.buf.signature_help)
  (evil-local-set-key 'insert (kbd "C-h")
                      #'eldoc-box-help-at-point))

(add-hook 'eglot-managed-mode-hook #'my/lsp-keybindings)

;;    Leader key                                                                 
(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key

    ;;    Files                                                               
    "ff" 'helm-find-files
    "fs" 'save-buffer

    ;;    Buffers                                                             
    "bb" 'helm-buffers-list   ; fuzzy buffer list, much better than list-buffers
    "bk" 'kill-buffer
    "br" 'helm-recentf        ; recent files

    ;;    Bookmarks                                                           
    "rl" 'bookmark-bmenu-list
    "rb" 'helm-bookmarks

    ;;    Projects                                                            
    "pp" 'helm-projectile-switch-project
    "pf" 'helm-projectile-find-file
    "pb" 'helm-projectile-switch-to-buffer
    "pk" 'projectile-kill-buffers
    "pr" 'helm-projectile-recentf

    ;;    LSP / Code                                                          
    ;; mirrors: <C-q> code_action (also accessible via leader)
    "ca" 'eglot-code-actions

    ;; mirrors: <leader>vrn rename
    "vrn" 'eglot-rename

    ;; mirrors: gd definition + <leader>vrr references
    "cd"  'xref-find-definitions
    "vrr"  'xref-find-references

    ;; mirrors: <leader>vws workspace_symbol
    "vws" 'eglot-find-declaration

    ;; mirrors: C-f format (your original binding)
    "cf"  'eglot-format-buffer

    ;;    Hover / Docs                                                        
    ;; mirrors: <leader>k vim.lsp.buf.hover { border = "single" }
    "k"   'eldoc-box-help-at-point

    ;;    Diagnostics                                                         
    ;; mirrors: <leader>vd diagnostic.open_float
    "vd"  'flymake-show-buffer-diagnostics

    ;; mirrors: [d / ]d goto next/prev (also on g-keys above)
    "vn"  'flymake-goto-next-error
    "vp"  'flymake-goto-prev-error))

(provide 'evil-config)
