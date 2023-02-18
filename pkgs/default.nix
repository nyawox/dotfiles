final: prev: {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) {};
  # then, call packages with `final.callPackage`
  nixos-blur = final.callPackage (import ./nixos-blur.nix) {};
}
