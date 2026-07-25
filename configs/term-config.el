(use-package ghostel
  :ensure t)

(use-package evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))

(when (eq system-type 'windows-nt)
  (setq ghostel-shell "powershell.exe"))

(defun my/ghostel-buf ()
  "Return the most recent ghostel buffer, or nil if none exists."
  (seq-find (lambda (buf)
              (with-current-buffer buf
                (derived-mode-p 'ghostel-mode)))
            (buffer-list)))

(defun my/ghostel-toggle ()
  "Toggle a ghostel terminal in a dedicated right split, like `magit-status'."
  (interactive)
  (let ((buf (my/ghostel-buf)))
    (cond
     ;; Already looking at it -> close the split
     ((and buf (eq (current-buffer) buf))
      (if (one-window-p) (bury-buffer) (delete-window)))
     ;; Exists somewhere off-screen -> pull it into a fresh split
     (buf
      (select-window
       (split-window-right))
      (switch-to-buffer buf))
     ;; Doesn't exist yet -> split first, then let ghostel land in it
     (t
      (select-window
       (split-window-right))
      (ghostel)))))

(add-to-list 'display-buffer-alist
             '((major-mode . ghostel-mode)
               (display-buffer-reuse-window display-buffer-in-direction)
               (direction . right)
               (window-width . 0.3)))

;; (with-eval-after-load 'ghostel
;;   (add-to-list 'ghostel-keymap-exceptions "C-g"))
;; (global-set-key (kbd "C-t") 'my/ghostel-toggle)

;; (with-eval-after-load 'evil-leader
;;   (evil-leader/set-key "tt" #'my/ghostel-toggle))

(global-set-key (kbd "C-x C-t") #'my/ghostel-toggle)

(provide 'term-config)
