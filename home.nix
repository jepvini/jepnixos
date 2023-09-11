{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
  {
    imports = [
      (import "${home-manager}/nixos")
    ];

    home-manager.users.leo = {
      /* The home.stateVersion option does not have a default and must be set */
      home.stateVersion = "18.09";

      programs.fish = {
        enable = true;
        shellAliases = {
          v = "nvim";
          c = "clear";
          rm = "trash";
          edit = "cd /etc/nixos";
        };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  programs.git = {
    enable = true;
    userName = "leo359531";
    userEmail = "leos1359531@gmail.com";
  };


  # Theme selector
  imports = [
    ./dotfiles/dotfiles.nix
    ./themes/kanagawa/kanagawa.nix
    # ./themes/rick/rick.nix
  ];

};
}
