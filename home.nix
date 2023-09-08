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
        plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "async-prompt"; src = pkgs.fishPlugins.async-prompt.src; }
      { name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
    ];
    shellAliases = {
      v = "nvim";
      c = "clear";
      grep = "rp";
      rm = "trash";
    };
    interactiveShellInit = ''
    set fish_greeting # Disable greeting
    '';
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



# Config
xdg.configFile = {
  "bin" = {
    recursive = true;
    source = ./dotfiles/bin;
    target = "bin";
  };
  "imgs" = {
    recursive = true;
    source = ./dotfiles/imgs;
    target = "imgs";
  };
  "mako" = {
    recursive = true;
    source = ./dotfiles/mako;
    target = "mako";
  };
  "neofetch" = {
    recursive = true;
    source = ./dotfiles/neofetch;
    target = "neofetch";
  };
  "nvim" = {
    recursive = true;
    source = ./dotfiles/nvim;
    target = "nvim";
  };
  "rofi" = {
    recursive = true;
    source = ./dotfiles/rofi;
    target = "rofi";
  };
  "spotifyd" = {
    recursive = true;
    source = ./dotfiles/spotifyd;
    target = "spotifyd";
  };
  "sway" = {
    recursive = true;
    source = ./dotfiles/sway;
    target = "sway";
  };
  "swaylock" = {
    recursive = true;
    source = ./dotfiles/swaylock;
    target = "swaylock";
  };
  "waybar" = {
    recursive = true;
    source = ./dotfiles/waybar;
    target = "waybar";
  };
  "wezterm" = {
    recursive = true;
    source = ./dotfiles/wezterm;
    target = "wezterm";
  };
  "rick" = {
    recursive = true;
    source = ./dotfiles/rick;
    target = "rick";
  };
};
  };
}
