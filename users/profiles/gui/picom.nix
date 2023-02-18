{ pkgs, ... }:
{
  services.picom = {
    enable = true;
    package = pkgs.picom-animations;
    backend = "glx";
    fade = true;
    settings = {
      corner-radius = 10.0;
      xrender-sync-fence = true;
    };
  };
}
