{ suites, ... }:
{
  home-manager.users.dxm = { suites, ... }: {
    imports = suites.dxm;
    home.stateVersion = "23.05";
  };

  users.users.dxm = {
    password = "nixos";
    description = "DXM";
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" ];
  };
}
