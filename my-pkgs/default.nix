{pkgs, ...}: let
  callPackage = pkgs.callPackage;
in {
  nixpkgs.overlays = [
    (final: prev: {
      jep = {
        fast-sl = callPackage ./fast-sl.nix {};
        jepmap = callPackage ./jepmap.nix {};
        kanagawa-gtk = callPackage ./kanagawa-gtk.nix {};
        modprobed-db = callPackage ./modprobed-db.nix {};
        ngspice = callPackage ./ngspice.nix {};
        nofetch = callPackage ./nofetch.nix {};
        setPL = callPackage ./setPL.nix {};
      };
    })
  ];
}
