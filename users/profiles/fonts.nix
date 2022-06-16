{ pkgs, ... }:
let
  nerdFonts = pkgs.nerdfonts.override {
    fonts = [ "Iosevka" ];
  };
in
{
  fonts.fontconfig = {
    enable = true;
  };
  home.packages = with pkgs; [
    nerdFonts
    corefonts
    noto-fonts-cjk
    fantasque-sans-mono
    source-code-pro
    emacs-all-the-icons-fonts
    material-design-icons
    twitter-color-emoji
  ];
}
