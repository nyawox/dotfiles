{ config, ... }:
{
  programs.rofi = {
    enable = true;
    theme = toString "~/.config/rofi/palenight.rasi";
    font = "Source Code Pro 15";
    extraConfig = {
      show-icons = true;
    };
  };
}
