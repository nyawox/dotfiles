{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold Italic";
        };
        size = 10.0;
      };
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
      };
      window = {
        opacity = 1;
      };
      colors = {
        # Default colors
        primary = {
          background = "0x292d3e";
          foreground = "0x959dcb";
        };
        # Colors the cursor will use if `custom_cursor_colors` is true
        cursor = {
          text = "0x292d3e";
          cursor = "0x959dcb";
        };

        # Normal colors
        normal = {
          black = "0x292d3e";
          red = "0xf07178";
          green = "0xc3e88d";
          yellow = "0xffcb6b";
          blue = "0x82aaff";
          magenta = "0xc792ea";
          cyan = "0x89ddff";
          white = "0x959dcb";
        };

        # Bright colors
        bright = {
          black = "0x676e95";
          red = "0xf07178";
          green = "0xc3e88d";
          yellow = "0xffcb6b";
          blue = "0x82aaff";
          magenta = "0xc792ea";
          cyan = "0x89ddff";
          white = "0xffffff";
        };
      };
    };
  };
}
