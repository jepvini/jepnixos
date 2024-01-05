{
  config,
  pkgs,
  ...
}: {
  # Use latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  services.zfs.autoScrub.enable = true; # auto scrub zfs
  boot.kernelParams = ["nohibernate" "quiet" "zfs.zfs_arc_max=17179869184"];
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

    # Tlp
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;

        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 50;
        RUNTIME_PM_ON_BAT = "auto";

        TLP_DEFAULT_MODE = "BAT";

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        CPU_MIN_PERF_ON_AC = "100";
        CPU_MAX_PERF_ON_AC = "100";
        CPU_MIN_PERF_ON_BAT = "0";
        CPU_MAX_PERF_ON_BAT = "100";

        CPU_BOOST_ON_AC = "1";
        CPU_BOOST_ON_BAT = "1";
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
    bat # cat with colors
    bc # calculator -> for the watt script
    cmake # bild system generator
    ctags # fast source code browsing
    devmem2 # read from memory
    eza # fast ls
    fd # better find
    feh # image viewer
    ffmpeg # trascoder
    firestarter # stress test for s-tui
    flac # music encoder
    fortune # random quote generator
    fzf # fuzzy search
    gccgo # C compiler
    git # really?
    gnumake # make command
    grc # colours
    grim # screenshots
    jq # JSON processor
    linuxKernel.packages.linux_6_6.turbostat # cpu stats
    lolcat # rainbow
    msr-tools # edit cpu parameters
    neofetch # system info
    num-utils # random
    openvpn # vpn client
    pamixer # set volume
    pciutils # pci ultis
    pulseaudio # for pactl
    rclone # for nexcloud sync
    ripgrep # rust written grep
    s-tui # cpu monitoring and stress test
    stdenv # C compilers
    stress-ng # stress test
    trash-cli # trash for terminal
    tree # ls files in folders
    uwuify # UwU
    ventoy-full # multi boot USB
    wayvnc # vnc server for wayland
    wget # retrieve files using HTTP etc.
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
    evince # pdf
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
    sonixd # music player
    thunderbird # mail
    virt-manager # virtual machines

    # Non-free
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
    jep.fast-sl
    jep.modprobed-db
    jep.ngspice
    jep.nofetch
    jep.setPL
    jep.jepmap
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
