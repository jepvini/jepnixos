{
  config,
  pkgs,
  ...
}: let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.leo = {
    /*
    The home.stateVersion option does not have a default and must be set
    */
    home.stateVersion = "23.05";

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        any-nix-shell fish --info-right | source
      '';
      shellAliases = {
        v = "nvim";
        c = "clear";
        rm = "trash";
        edit = "cd /etc/nixos";
        cat = "bat";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Compact-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["blue"];
          size = "compact";
          tweaks = ["rimless" "black"];
          variant = "macchiato";
        };
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
      style.name = "Catppuccin-Macchiato-Compact-Blue-Dark";
      style.package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "compact";
        tweaks = ["rimless" "black"];
        variant = "macchiato";
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
