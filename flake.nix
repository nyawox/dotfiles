{
  description = "WIPWIPWIP";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org https://emacsng.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= emacsng.cachix.org-1:i7wOr4YpdRpWWtShI8bT6V7lOTnPeI7Ho6HaZegFWMI=";

  inputs =
    {
      # Track channels with commits tested and built by hydra
      nixos.url = "github:nixos/nixpkgs/nixos-unstable";
      latest.url = "github:nixos/nixpkgs";

      digga.url = "github:divnix/digga";

      emacs-overlay.url = "github:nix-community/emacs-overlay";

      home.url = "github:nix-community/home-manager";
      home.inputs.nixpkgs.follows = "nixos";

      deploy.url = "github:serokell/deploy-rs";
      deploy.inputs.nixpkgs.follows = "nixos";

      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "nixos";

      nvfetcher.url = "github:berberman/nvfetcher";
      nvfetcher.inputs.nixpkgs.follows = "nixos";

      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "nixos";

      nixos-hardware.url = "github:nixos/nixos-hardware";

      nixos-generators.url = "github:nix-community/nixos-generators";
    };

  outputs =
    { self
    , digga
    , nixos
    , home
    , nixos-hardware
    , nur
    , agenix
    , nvfetcher
    , deploy
    , nixpkgs
    , ...
    } @ inputs':
    let
      # TODO https://github.com/divnix/digga/issues/464
      inputs = inputs' // {
        emacs-overlay = inputs'.emacs-overlay // {
          overlay = self.lib.overlayNullProtector inputs'.emacs-overlay.overlay;
        };
      };
    in
      digga.lib.mkFlake
        {
          inherit self inputs;

          channelsConfig = { allowUnfree = true; };

          channels = {
            nixos = {
              imports = [ (digga.lib.importOverlays ./overlays) ];
              overlays = [];
            };
            latest = { };
          };

          lib = import ./lib { lib = digga.lib // nixos.lib; };

          sharedOverlays = [
            (final: prev: {
              __dontExport = true;
              lib = prev.lib.extend (lfinal: lprev: {
                our = self.lib;
              });
            })

            nur.overlay
            agenix.overlays.default
            nvfetcher.overlays.default
            inputs.emacs-overlay.overlay

            (import ./pkgs)
          ];

          nixos = {
            hostDefaults = {
              system = "x86_64-linux";
              channelName = "nixos";
              imports = [ (digga.lib.importExportableModules ./modules) ];
              modules = [
                { lib.our = self.lib; }
                digga.nixosModules.bootstrapIso
                digga.nixosModules.nixConfig
                home.nixosModules.home-manager
                agenix.nixosModules.age
              ];
            };

            imports = [ (digga.lib.importHosts ./hosts) ];
            hosts = {
              /* set host-specific properties here */
              pakipaki = { };
            };
            importables = rec {
              profiles = digga.lib.rakeLeaves ./profiles // {
                users = digga.lib.rakeLeaves ./users;
              };
              suites = with profiles; rec {
                base = [ core.nixos users.dxm users.root ];
              };
            };
          };

          home = {
            imports = [ (digga.lib.importExportableModules ./users/modules) ];
            modules = [
            ];
            importables = rec {
              profiles = digga.lib.rakeLeaves ./users/profiles;
              suites = with profiles; {
                gui = with gui; [ programs gtk qutebrowser alacritty emacs xmonad bar rofi picom inputmethod ];
                shell = with shell; [ direnv git ];

                dxm = with suites; [ gui shell files ];
              };
            };
          };

          devshell = ./shell;

          homeConfigurations = digga.lib.mergeAny
            (digga.lib.mkHomeConfigurations self.nixosConfigurations)
          ;

          deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

        }
  ;
}
