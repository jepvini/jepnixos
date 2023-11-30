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

    programs.zsh = {
      enable = true;
      shellAliases = {
        v = "nvim";
        l = "exa -ahl";
        c = "clear && sl && clear";
        rm = "trash";
        edit = "cd /etc/nixos";
        ilmatar = "ssh -p 59743 vainamoinen@scatcat.online";
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
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
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 22;
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
