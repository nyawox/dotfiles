{ pkgs, ... }:
let
  nerdFonts = pkgs.nerdfonts.override {
    fonts = [ "Iosevka" ];
  };
in
{
  fonts = {
    fonts = with pkgs; [
      nerdFonts
      corefonts
      noto-fonts
      noto-fonts-cjk
      source-han-sans
      source-han-serif
      fantasque-sans-mono
      source-code-pro
      sarasa-gothic
      emacs-all-the-icons-fonts
      material-design-icons
      twitter-color-emoji
    ];
    enableDefaultFonts = true;
    fontconfig.defaultFonts = {
      serif = [ "Source Han Serif" "Noto Serif CJK JP" ];
      sansSerif = [ "Source Han Sans" "Noto Sans CJK JP" ];
      monospace = [ "Sarasa Mono J" "Iosevka Nerd Font" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
