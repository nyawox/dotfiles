{ pkgs, ... }:
{
  services.picom = {
    enable = true;
    package = pkgs.nur.repos.xeals.picom-animations;
    backend = "glx";
    experimentalBackends = true;
    fade = true;
    extraOptions = ''
      corner-radius = 10.0;
      xrender-sync-fence = true;
    '';
  };
}
