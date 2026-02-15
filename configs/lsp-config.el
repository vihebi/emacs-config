;; Lsp configuration

;; Rust
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (setq rust-format-on-save t))

;; LSP via eglot
(use-package eglot
  :hook ((rust-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (c++-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t)
  (add-to-list 'eglot-server-programs
               '(rust-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode) . ("clangd"))))
(global-set-key (kbd "C-f") 'eglot-format-buffer)


;; Treesitter with auto-install
;; (use-package treesit-auto
;;   :config
;;   (setq treesit-auto-install 'prompt)  ; or t for auto-install
;;   (global-treesit-auto-mode))

;; Completion
(use-package company
  :config
  (global-company-mode 1)
  (define-key company-mode-map (kbd "<C-tab>") 'company-complete)
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

;; CMake support
(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

;; Cargo integration
(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(provide 'lsp-config)
