{ pkgs, ... }:
{
  services.picom = {
    enable = true;
    package = pkgs.picom-animations;
    backend = "glx";
    fade = true;
    settings = {
      corner-radius = 11;
      xrender-sync-fence = true;
      animations = true;
      animation-stiffness-in-tag = 120;
      animation-stiffness-tag-change = 90;
      animation-dampening = 17;
      animation-clamping = false;
      animation-for-open-window = "zoom";
      animation-for-unmap-window = "squeeze";
      animation-for-transient-window = "slide-up";
      animation-for-prev-tag = "minimize";
      enable-fading-prev-tag = true;
      animation-for-next-tag = "slide-in-center";
      enable-fading-next-tag = true;
    };
  };
}
