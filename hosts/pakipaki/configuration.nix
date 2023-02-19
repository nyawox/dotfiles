# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = [ ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 120;
    editor = false;
    extraEntries = {
      "windows.conf" = ''
        title Windows
        efi /EFI/Microsoft/Boot/bootmgfw.efi
      '';
    };
  };
  boot.plymouth = {
    enable = true;
    # theme = "nixos-blur";
    # themePackages = [ pkgs.nixos-blur ];
  };
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "libahci.ignore_sss=1"
    "quiet"
    "splash"
    "allow_discards"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "vt.global_cursor_default=0"
    "boot.shell_on_fail"
    "nowatchdog"
  ];
  boot.loader.timeout = 0;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=30s
    DefaultTimeoutStopSec=10s
  '';

  boot.initrd.systemd.enable = true;
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-4a4dcd5c-f23b-4e19-aa18-4fd12704f208".device = "/dev/disk/by-uuid/4a4dcd5c-f23b-4e19-aa18-4fd12704f208";
  boot.initrd.luks.devices."luks-4a4dcd5c-f23b-4e19-aa18-4fd12704f208".keyFile = "/crypto_keyfile.bin";

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # boot faster
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.dhcpcd.enable = false;
  networking.useNetworkd = true;
  # Don't wait for network startup
  # https://old.reddit.com/r/NixOS/comments/vdz86j/how_to_remove_boot_dependency_on_network_for_a
  systemd.targets.network-online.wantedBy = pkgs.lib.mkForce [ ]; # Normally ["multi-user.target"]
  systemd.services.NetworkManager-wait-online.wantedBy = pkgs.lib.mkForce [ ]; # Normally ["network-online.target"]
  systemd.services.systemd-networkd-wait-online.enable = pkgs.lib.mkForce false;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/ee1462e7-2b45-4828-91cc-5b39df2cea9d";
      fsType = "ext4";
    };
  boot.initrd.luks.devices."luks-56c8fa00-672d-449f-ba2c-52e8d2e002ab".device = "/dev/disk/by-uuid/56c8fa00-672d-449f-ba2c-52e8d2e002ab";
  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/BF3B-8DB4";
      fsType = "vfat";
    };
  swapDevices =
    [{ device = "/dev/disk/by-uuid/56e56582-4bb3-4e12-bb44-2b6ab20a1cb6"; }];
  services.fstrim.enable = true;

  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

  services.fwupd.enable = true;
  services.irqbalance.enable = true;

  networking.hostName = "pakipaki"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.utf8";
    LC_IDENTIFICATION = "ja_JP.utf8";
    LC_MEASUREMENT = "ja_JP.utf8";
    LC_MONETARY = "ja_JP.utf8";
    LC_NAME = "ja_JP.utf8";
    LC_NUMERIC = "ja_JP.utf8";
    LC_PAPER = "ja_JP.utf8";
    LC_TELEPHONE = "ja_JP.utf8";
    LC_TIME = "ja_JP.utf8";
  };

  security.polkit.enable = true;
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
    xkbVariant = "dvorak";
    videoDrivers = [ "nvidia" ];
    displayManager = {
      defaultSession = "none+xmonad";
      autoLogin.enable = true;
      autoLogin.user = "dxm";
      lightdm = {
        enable = true;
        greeter.enable = true;
        greeters.mini.enable = true;
        greeters.mini.user = "dxm";
      };
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };
  services.usbmuxd.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;


  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };

  environment.etc."gbinder.d/waydroid.conf".source = lib.mkForce
    (pkgs.writeText "waydroid.conf" ''
      [Protocol]
      /dev/binder = aidl3
      /dev/vndbinder = aidl3
      /dev/hwbinder = hidl

      [ServiceManager]
      /dev/binder = aidl3
      /dev/vndbinder = aidl3
      /dev/hwbinder = hidl

      [General]
      ApiLevel = 30
    '');

  # Configure console keymap
  console.keyMap = "dvorak";

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dxm = {
    isNormalUser = true;
    description = "DXM";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "dxm";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ "root" "dxm" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.gamemode.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
