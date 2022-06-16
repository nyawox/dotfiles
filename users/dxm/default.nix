{ suites, ... }:
{
  home-manager.users.dxm = { suites, ... }: {
    imports = suites.dxm;
  };

  users.users.dxm = {
    password = "nixos";
    description = "DXM";
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" ];
  };
}
