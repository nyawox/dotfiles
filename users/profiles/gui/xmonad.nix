{
  xsession = {
    enable = true;
    profileExtra = ''
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS=@im=fcitx
      xrandr --output DVI-D-0 --primary --scale-from 2560x1440
      xrandr --output DVI-D-1 --scale-from 2560x1440 --pos 2560x0
      setxkbmap -layout dvorak
      fcitx5 &
    '';
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };
}
