{ config, pkgs, ... }:
{

# Use latest kernel
boot.kernelPackages = pkgs.linuxPackages_latest;

# Virt-Manager
virtualisation.libvirtd.enable = true;
programs.dconf.enable = true;

# Thunar
programs.thunar.enable = true;
programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin # archives
  thunar-media-tags-plugin # metadata
  thunar-volman # volumes management
];
services.gvfs.enable = true; # Mount, trash, and other functionalities
services.tumbler.enable = true; # Thumbnail support for images

# Neovim
programs.neovim = {
  enable = true;
  defaultEditor = true;
};

# Enable
programs = {
  fish.enable = true;
  light.enable = true; # brightness control
  waybar.enable = true; # bar
  ssh.startAgent = true; # ssh command
};


# Services
services = {

# Dns
resolved = {
  enable = true;
  fallbackDns = [
    "8.8.8.8"
    "2001:4860:4860::8844"
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
tailscale.enable = false;
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
    rofi-wayland # laucher
    swaybg
    swayidle
    swaylock
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
extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

# List packages installed in system profile. To search run:
# $ nix search wget
environment.systemPackages = with pkgs; [

# Cli
alsa-utils # some audio utils like aplay
bc # calculator -> for the watt script
cmake # bild system generator
ctags # fast source code browsing
exa # fast ls
fd # better find
feh # image viewer
fortune # random quote generator
gccgo # C compiler
git # really?
grc # text colouriser
grim # screenshots
jq # JSON processor
neofetch # system info
nnn # files manager
openvpn # vpn client
pamixer  # set volume
ripgrep # rust written grep
spotifyd # spotify daemon
stdenv # C compilers
trash-cli # trash for terminal
tree # ls files in folders
tree-sitter # for nvim
uwuify # UwU
wget # retreve files using HTTP etc.

#  Archives
p7zip
unzip
xz
zip
xarchiver # for thunar

# Compatibility
steam-run # all in one bin patcher

# Tui
bashmount # mount disks
btop # task manager
ncspot # spotify client
powertop # power usage info
spotify-tui # spotify client
vim # backup text editor

# Gui
firefox-wayland
font-manager # useful for choosing glyphs
libreoffice-qt # libre offive suite
mpvpaper # live wall paper
thunderbird # mail
transmission-gtk # definitely not for torrents
virt-manager # virtual machines
pavucontrol # audio control

# Non-free
spotify
telegram-desktop
megasync # mega client

# Python
(python3.withPackages(ps: with ps; [  ]))

# Nodejs
nodejs

# GTK
yaru-theme # gtk themej

# Libs

# HTB
aircrack-ng # wifi
hydra-check # checks hydra modules
john # hash
netcat-openbsd # reverse shell
nmap # net enumeration
thc-hydra # ssh and other protocols
samba # smbclient

      ];

# Fonts
fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "ComicShannsMono" "OpenDyslexic" ]; })
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
boot.kernelParams = [ "quiet" ];
boot.consoleLogLevel = 0;
}
