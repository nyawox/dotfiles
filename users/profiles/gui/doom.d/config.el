;; Appearance
(setq doom-theme 'doom-palenight
      doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 10.0)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 10.0))

(setq fancy-splash-image "~/.doom.d/splash.png")

;; Indent line
(setq highlight-indent-guides-method 'bitmap
      highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line)
(setq display-line-numbers-type 'relative)

(setq centaur-tabs-style "chamfer")
(after! centaur-tabs
  (setq centaur-tabs-set-bar 'right))

(use-package! beacon)
(after! beacon (beacon-mode 1))

(use-package treemacs-projectile
  :after (treemacs projectile))
(after! (treemacs projectile)
  (treemacs-project-follow-mode 1))

(use-package volatile-highlights
  :diminish
  :hook
  (after-init . volatile-highlights-mode)
  :custom-face
  (vhl/default-face ((nil (:foreground "#FF3333" :background "#FFCDCD")))))
