{pkgs, ...}: let
  callPackage = pkgs.callPackage;
in {
  nixpkgs.overlays = [
    (final: prev: {
      gitPkgs = {
        fast-sl = callPackage ./gitPkgs/fast-sl.nix {};
        kanagawa-gtk = callPackage ./gitPkgs/kanagawa-gtk.nix {};
        nofetch = callPackage ./gitPkgs/nofetch.nix {};
      };
    })
  ];
}
