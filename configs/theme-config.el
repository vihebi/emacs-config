;; Appearance Config

;; Font
(set-face-attribute 'default nil
  :family "Iosevka NF"
  :height 120)  ; height in 1/10 pt (120 = 12pt)

;; A vertical line. For some reason this translates to 120
(setq-default display-fill-column-indicator-column 107)
(setq-default display-fill-column-indicator-character ?\ )
(set-face-attribute 'fill-column-indicator nil :background nil :stipple '(7 1 " "))
(global-display-fill-column-indicator-mode 1)

;; disable 1785 stuff
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Theme
(use-package doom-themes
  :config
  (load-theme 'doom-ayu-dark t))
;;  (load-theme 'doom-plain-dark t))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Modeline clock config
(setq display-time t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date nil)
(setq display-time-string-forms
      '((format "[%s %s.%02d | %s:%s]"
                dayname
                day
                (string-to-number month)
                24-hours
                minutes)))

(display-time-mode 1)
(setq doom-modeline-time-icon nil)

(provide 'theme-config)
