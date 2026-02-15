;; Org settings

(with-eval-after-load 'org
  (setq org-hide-emphasis-markers t)
  (setq org-startup-with-inline-images t)
  
  ;; Add gd binding for opening links
  (evil-define-key 'normal org-mode-map
    (kbd "gd") 'org-open-at-point))

(provide 'org-config)
