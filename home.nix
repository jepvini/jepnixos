{
  config,
  pkgs,
  ...
}: let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.leo = {
    /*
    The home.stateVersion option does not have a default and must be set
    */
    home.stateVersion = "23.11";

    programs.bash = {
      enable = true;
      enableCompletion = true;
      historyControl = [
        "erasedups"
        "ignorespace"
      ];
      historySize = 10000;
      historyIgnore = [
        "l"
        "cd"
        "v"
      ];

      # complete -cf doas enables autocomplete with doas
      initExtra = ''
        complete -cf doas
        bind -s 'set completion-ignore-case on'
        nofetch -UwU
      '';

      shellAliases = {
        add = "ssh-add ~/.ssh/starless";
        c = "clear && fast-sl && clear";
        duu = "du --max-depth=1 -h";
        edit = "cd /etc/nixos";
        ilmatar = "ssh -p 59743 vainamoinen@dreams.scatcat.online";
        j = "autojump";
        l = "exa -ahl";
        ll = "ls -l";
        lsblk = "lsblk -o NAME,FSTYPE,SIZE,FSUSED,LABEL,MOUNTPOINT,RM,RO,UUID";
        rm = "trash";
        update = "sudo nixos-rebuild switch";
        v = "nvim";
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
    ];
  };
}
