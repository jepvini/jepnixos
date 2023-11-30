{
  config,
  pkgs,
  ...
}: {
  # Use latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  services.zfs.autoScrub.enable = true; # auto scrub zfs
  boot.kernelParams = ["nohibernate" "quiet"];
  boot.consoleLogLevel = 0;

  # Virt-Manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # SSH angent
  programs.ssh.startAgent = true;

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.tmux = {
    enable = true;
  };

  # Enable
  programs = {
    zsh.enable = true;
    light.enable = true; # brightness control
    waybar.enable = true; # bar
  };

  # Services
  services.avahi = {
    nssmdns = true;
    enable = true;
    publish = {
      enable = true;
      userServices = true;
      domain = true;
    };
  };
  services = {
    # Avahi
    # avahi = {
    # enable = true;
    # };
    # Dns
    resolved = {
      enable = true;
      fallbackDns = [
        "208.67.222.222"
        "2620:119:35::35"
      ];
    };

    # Fprint - fingerprint
    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix-550a;
      };
    };

    # Power Management
    # Thermald
    thermald.enable = true;

    # Tlp
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_BAT = 1;
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
        RUNTIME_PM_ON_BAT = "auto";
      };
    };

    # Tailscale
    tailscale.enable = true;
  };

  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      alacritty # backup terminal
      bemenu
      libnotify # notification library
      mako # notification daemon
      rofi-wayland # launcher
      sov # workspaces content
      swaybg # bg
      swayidle # idle control
      swaylock # lock command
      wezterm # terminal
      wf-recorder # screen recording
      wl-clipboard # access to system buffer
      xwayland # non wayland compatibility
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };

  # Screen sharing sway
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Android
  programs.adb.enable = true;
  users.users.leo.extraGroups = ["adbusers"];

  # List packages installed in system profile. To search run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Test

    # Cli
    alsa-utils # some audio utils like aplay
    any-nix-shell # fish with nix-shell
    bat # cat with colors
    bc # calculator -> for the watt script
    cmake # bild system generator
    ctags # fast source code browsing
    eza # fast ls
    fd # better find
    feh # image viewer
    ffmpeg # trascoder
    flac # music encoder
    fortune # random quote generator
    fzf # fuzzy search
    gccgo # C compiler
    git # really?
    gnumake # make command
    grc # colours
    grim # screenshots
    helix # test editor written in rust
    jq # JSON processor
    lolcat # rainbow
    neofetch # system info
    nextcloud-client # nextcloud client
    nnn # files manager
    num-utils # random
    openvpn # vpn client
    pamixer # set volume
    pulseaudio # for pactl
    rclone # for nexcloud sync
    ripgrep # rust written grep
    stdenv # C compilers
    trash-cli # trash for terminal
    tree # ls files in folders
    uwuify # UwU
    ventoy-full # multi boot USB
    wayvnc # vnc server for wayland
    wget # retrieve files using HTTP etc.
    wireguard-tools # wg
    zfs # cool file system

    #  Archives
    p7zip
    unzip
    xarchiver # for file manager
    xz
    zip

    # Compatibility
    steam-run # all in one bin patcher

    # Tui
    bashmount # mount disks
    btop # task manager
    powertop # power usage info
    vim # backup text editor

    # Gui
    baobab # disk space manager
    chromium # chromium
    firefox-wayland
    font-manager # useful for choosing glyphs
    gimp # editor
    kicad # electronic design
    libreoffice-qt # libre offive suite
    mpv # media player
    mpvpaper # live wall paper
    pavucontrol # audio control
    pcmanfm # file manager
    plexamp # plex audio player
    sonixd # music player
    thunderbird # mail
    transmission-gtk # definitely not for torrents
    virt-manager # virtual machines

    # Non-free
    soulseekqt
    spotify
    telegram-desktop

    # Python
    (python3.withPackages (ps:
      with ps; [
      ]))

    # Nodejs
    nodejs

    # Rust
    cargo
    rustc

    # Lua
    lua
    love

    #
    # nvim
    #
    glow # md previewer
    tree-sitter # for nvim

    # lsp
    clang # clang
    clang-tools # C, C++
    lua-language-server # lua
    marksman # markdown
    nil # nix
    nodePackages_latest.bash-language-server # bash
    pyright # python
    rust-analyzer # rust
    shellcheck # checks shell scripts
    yaml-language-server # yaml

    # formatteri
    alejandra # nix
    beautysh # sh
    black # python
    codespell # spell check
    isort # python
    jq # json
    nodePackages_latest.prettier # prettier
    python311Packages.mdformat # python
    stylua # lua

    # HTB
    aircrack-ng # wifi
    gobuster # file enumeration
    hydra-check # checks hydra modules
    john # hash
    netcat-openbsd # reverse shell
    nmap # net enumeration
    samba # smbclient
    thc-hydra # ssh and other protocols

    # Octave
    (octave.withPackages
      (opkgs: with opkgs; [symbolic]))

    # Android
    android-tools
    newt
    pv
    srm

    # Gtk
    gnome-themes-extra
    gtk-engine-murrine

    # gitPkgs
    gitPkgs.nofetch
    gitPkgs.fast-sl
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "ComicShannsMono" "OpenDyslexic"];})
  ];

  # Bootloader
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "leo";
      };
    };
  };
}
