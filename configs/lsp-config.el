;; lsp-config.el   mirrors nvim eglot + nvim-cmp + conform + fidget setup

;; Corfu - inline completion (replaces company, mirrors nvim-cmp)             
(use-package corfu
  :custom
  (corfu-auto t)                  ; like company-idle-delay
  (corfu-auto-delay 0.1)          ; matches company-idle-delay 0.1
  (corfu-auto-prefix 1)           ; matches company-minimum-prefix-length 1
  (corfu-cycle t)                 ; wrap around like nvim-cmp
  (corfu-preselect 'prompt)       ; don't auto-select first item
  :bind
  (:map corfu-map
        ;; mirrors: C-o = prev, C-p = next, C-Space = open, CR = confirm
        ("C-o"     . corfu-previous)
        ("C-p"     . corfu-next)
        ("C-SPC"   . corfu-insert)
        ("<tab>"   . corfu-next)     ; also useful on Windows
        ("<return>" . corfu-insert))
  :init
  (global-corfu-mode))

;; Cape   extra completion sources (mirrors cmp-buffer, cmp-path, cmp-cmdline)
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)    ; cmp-path
  (add-to-list 'completion-at-point-functions #'cape-dabbrev) ; cmp-buffer
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;;    Eglot   LSP client (same role as nvim-lspconfig)                          
(use-package eglot
  :hook ((rust-mode    . eglot-ensure)
         (c-mode       . eglot-ensure)
         (c++-mode     . eglot-ensure)
         (lua-mode     . eglot-ensure))
  :custom
  (eglot-autoshutdown t)
  ;; Show all diagnostics in the eldoc echo area (like nvim's virtual text)
  (eglot-ignored-server-capabilities '())
  :config
  ;; Server programs   mirrors mason ensure_installed + handlers
  (add-to-list 'eglot-server-programs '(rust-mode    . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("clangd")))
  (add-to-list 'eglot-server-programs '(lua-mode     . ("lua-language-server")))

  ;; Merge eglot + cape sources into a single capf (mirrors nvim-cmp source list)
  (defun my/eglot-capf ()
    (setq-local completion-at-point-functions
                (list (cape-capf-super
                       #'eglot-completion-at-point
                       #'cape-file
                       #'cape-dabbrev))))
  (add-hook 'eglot-managed-mode-hook #'my/eglot-capf)

  ;; Rounded diagnostic floats   mirrors vim.diagnostic.config float options
  (setq eldoc-echo-area-use-multiline-p nil) ; keep echo area tidy
  )

;;    Eldoc Box   hover float with border (mirrors <leader>k vim.lsp.buf.hover)  
(use-package eldoc-box
  :config
  ;; Render eldoc/hover in a child frame with a border, like nvim's "single" border
  (setq eldoc-box-border-color "gray40")
  (setq eldoc-box-max-pixel-width  700)
  (setq eldoc-box-max-pixel-height 400))

;;    Apheleia   formatting (mirrors conform.nvim)                              
(use-package apheleia
  :config
  ;; (apheleia-global-mode +1) ;; This is global format-on-save in layman's terms 
  ;; Rust: rustfmt (rust-mode sets rust-format-on-save; apheleia replaces that)
  (setq rust-format-on-save nil) ; let apheleia handle it
  (push '(rustfmt . ("rustfmt" "--edition" "2021")) apheleia-formatters)
  (setf (alist-get 'rust-mode apheleia-mode-alist) 'rustfmt)
  ;; clang-format for C/C++
  (setf (alist-get 'c-mode   apheleia-mode-alist) 'clang-format)
  (setf (alist-get 'c++-mode apheleia-mode-alist) 'clang-format))

;;    Flymake tweaks   diagnostic floats (mirrors vim.diagnostic.config)         
(use-package flymake
  :custom
  ;; Show diagnostics in the echo area automatically, like nvim's float on hover
  (flymake-show-diagnostics-at-end-of-line nil)
  (flymake-no-changes-timeout 0.5))


;;    Language packages                                                          
(use-package rust-mode
  :mode "\\.rs\\'")
(use-package lua-mode
  :mode "\\.lua\\'")
(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(provide 'lsp-config)
