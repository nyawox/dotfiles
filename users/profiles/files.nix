{ pkgs, ... }:
{
  home.file.".xinitrc".source = ./xinitrc;
  home.file.".wallpaper".source = ./wallpaper.jpg;
  home.file.".config/qutebrowser/theme.py".source = pkgs.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "base16-qutebrowser";
    rev = "64301dc1b590aacaef87e5954558cdbda79b036a";
    sha256 = "yl3IqFu3+UT39UU9L6tr569WQrMl40m4D3e59RNyTEE=";
  } + "/themes/default/base16-material-palenight.config.py";
  home.file.".config/rofi/palenight.rasi".source = pkgs.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "base16-rofi";
    rev = "3f64a9f8d8cb7db796557b516682b255172c4ab4";
    sha256 = "RZpjCQ8KGO3cv9A/lNNoTE+WJ9sNk5sz0zJq02zzxA8=";
  } + "/themes/base16-material-palenight.rasi";
  home.file.".doom.d/splash.png".source = pkgs.fetchFromGitHub {
    owner = "jeetelongname";
    repo = "doom-banners";
    rev = "38f24e1e5bbd190bb805fcaa400143eb2b426e71";
    sha256 = "DNa6Nqh0OcXP17o0soSkKUYASA+BBufq3uCrXMFSnmY=";
  } +"/splashes/emacs/emacs-e-logo.png";
}
