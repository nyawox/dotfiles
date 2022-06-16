{
  programs.xmobar = {
    enable = true;
    extraConfig = ''
     Config { font        = "xft:Iosevka Nerd Font-12"
            , borderColor = "#aa4668"
            , border      = FullB
            , borderWidth = 3
            , bgColor     = "#0c0816"
            , fgColor     = "#8fc5c6"
            , position    = Top
            , commands    =
                [ Run Cpu ["-t", "cpu: <fc=#4eb4fa><bar> <total>%</fc>"] 10
                , Run Memory ["-t","mem: <fc=#4eb4fa><usedbar> <usedratio>%</fc>"] 10
                , Run Date "date: <fc=#4eb4fa>%a %d %b %Y %H:%M:%S </fc>" "date" 10
                , Run XMonadLog
                              ]
            , sepChar     = "%"
            , alignSep    = "}{"
            , template    = " %XMonadLog% | %cpu% | %memory% }{%date%  "
            }
    '';
  };
}
