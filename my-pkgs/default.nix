{pkgs, ...}: let
  callPackage = pkgs.callPackage;
in {
  nixpkgs.overlays = [
    (final: prev: {
      gitPkgs = {
        fast-sl = callPackage ./gitPkgs/fast-sl.nix {};
        kanagawa-gtk = callPackage ./gitPkgs/kanagawa-gtk.nix {};
        ngspice = callPackage ./gitPkgs/ngspice.nix {};
        nofetch = callPackage ./gitPkgs/nofetch.nix {};
        modprobed-db = callPackage ./gitPkgs/modprobed-db.nix {};
      };
    })
  ];
}
