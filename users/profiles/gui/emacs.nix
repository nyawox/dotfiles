{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };
  services.emacs = {
    enable = true;
  };
  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
  };
}
