;; Appearance
(setq doom-theme 'doom-palenight
      doom-font (font-spec :family "Iosevka Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15))

(setq fancy-splash-image "~/.doom.d/splash.png")

;; Indent line
(setq highlight-indent-guides-method 'bitmap
      highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line)
(setq display-line-numbers-type 'relative)

(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(setq centaur-tabs-style "chamfer")
(after! centaur-tabs
  (setq centaur-tabs-set-bar 'right))

 (use-package! beacon)
 (after! beacon (beacon-mode 1))

(use-package treemacs-projectile
  :after (treemacs projectile))
(after! (treemacs projectile)
  (treemacs-project-follow-mode 1))
(setq doom-themes-treemacs-enable-variable-pitch nil)

