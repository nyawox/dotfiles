;; Appearance
(setq doom-theme 'doom-palenight
      doom-font (font-spec :family "Iosevka" :height 80))

;; Indent line
(setq highlight-indent-guides-method 'bitmap
      highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line)

;; Background-only transparency
;; requires emacs 29 master branch
(set-frame-parameter (selected-frame) 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))
