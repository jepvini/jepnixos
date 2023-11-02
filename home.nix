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
        fish_vi_key_bindings
        bind -s -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint-mode; end"
        fzf_configure_bindings --directory=\cf
      '';
      shellAliases = {
        v = "nvim";
        c = "clear && sl && clear";
        rm = "trash";
        edit = "cd /etc/nixos";
        cat = "bat";
        ilmatar = "ssh vainamoinen@100.99.35.148";
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
