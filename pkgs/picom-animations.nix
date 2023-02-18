{ pkgs, ... }:
{
    picom-animations = pkgs.picom.overrideAttrs (_oldAttrs: {
      pname = "picom-animations";
      src = pkgs.fetchFromGitHub {
        owner = "FT-Labs";
        repo = "picom";
      };
  });
}
