{pkgs, ...}: let
  callPackage = pkgs.callPackage;
in {
  nixpkgs.overlays = [(final: prev: {
    gitPkgs = {
      nofetch = callPackage ./gitPkgs/nofetch.nix {};
      kanagawa-gtk = callPackage ./gitPkgs/kanagawa-gtk.nix {};
      fast-sl = callPackage ./gitPkgs/fast-sl.nix {};
    };
  })];
}
