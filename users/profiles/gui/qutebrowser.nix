{
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://www.google.com/search?hl=en&q={}";
    };
    extraConfig = ''
      c.qt.args = ["enable-native-gpu-memory-buffers", "use-gl=desktop", "enable-accelerated-video-decode", "ignore-gpu-blacklist"]
    '';
  };
}
