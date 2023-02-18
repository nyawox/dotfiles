channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    cachix
    dhall
    element-desktop
    rage
    nix-index
    nixpkgs-fmt
    qutebrowser
    signal-desktop
    starship
    deploy-rs
    lutris
    heroic
    linuxPackages_xanmod_latest
    ;

  discord = prev.discord.override { withOpenASAR = true; };

  haskellPackages = prev.haskellPackages.override
    (old: {
      overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (hfinal: hprev:
        let version = prev.lib.replaceStrings [ "." ] [ "" ] prev.ghc.version;
        in
        {
          # same for haskell packages, matching ghc versions
          inherit (channels.latest.haskell.packages."ghc${version}")
            haskell-language-server;
        });
    });
  picom-animations = prev.picom.overrideAttrs (_oldAttrs: {
    pname = "picom-animations";
    src = prev.fetchFromGitHub {
      owner = "FT-Labs";
      repo = "picom";
      rev = "ad8feaad127746beaf2afe2b2ea37e7af204a2ac";
      sha256 = "3lZ41DkNi7FVyEwvMaWwOjLD2aZ6DxZhhvVQMnU6JrI=";
    };
    nativeBuildInputs = [
      prev.asciidoc
      prev.docbook_xml_dtd_45
      prev.docbook_xsl
      prev.makeWrapper
      prev.meson
      prev.ninja
      prev.pkg-config
      prev.uthash
      prev.pcre2
    ];
  });
}
