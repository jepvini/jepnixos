# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./pkgs.nix # Installed pkgs
    ./home.nix # Home Manager
    ./my-pkgs/default.nix
  ];

  # Defaults apps
  environment.variables = rec {
    EDITOR = "neovim";
    BROWSER = "firefox";
    TERMINAL = "wezterm";

    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    # XDG_BIN_HOME = "$HOME/.config/bin";
    PATH = [
      "$HOME/.config/bin"
    ];
  };

  # Trackpoint sensibility
  systemd.services.TrackpointSensibility = {
    enable = true;
    description = "Set trackpoint sensibility";
    after = [ "multi-user.target" ];
    startLimitBurst = 0;
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = true;
    serviceConfig = {
      Type = "oneshot";
      Restart= "on-failure";
      ExecStart = "${pkgs.bash}/bin/bash -c '/etc/nixos/services/TrackPointSensitivity'";
    };
  };

# Bootloader.
boot = {
  initrd.kernelModules = [];
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 5; # Limits entry number
  };
};

# Enable networking
networking = {
  hostName = "starless";
  networkmanager = {
    enable = true;
  };
};

# Bluetooth
hardware.bluetooth.enable = true;
services.blueman.enable = true;
hardware.bluetooth.settings = {
  General = {
    Enable = "Source,Sink,Media,Socket";
  };
};

# Audio
# rtkit is optional but recommended
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
# If you want to use JACK applications, uncomment this
jack.enable = true;
  };

# Set your time zone.
time.timeZone = "Europe/Rome";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";
i18n.extraLocaleSettings = {
  LC_ADDRESS = "it_IT.UTF-8";
  LC_IDENTIFICATION = "it_IT.UTF-8";
  LC_MEASUREMENT = "it_IT.UTF-8";
  LC_MONETARY = "it_IT.UTF-8";
  LC_NAME = "it_IT.UTF-8";
  LC_NUMERIC = "it_IT.UTF-8";
  LC_PAPER = "it_IT.UTF-8";
  LC_TELEPHONE = "it_IT.UTF-8";
  LC_TIME = "it_IT.UTF-8";
};

# Configure keymap in X11
services.xserver = {
  layout = "us";
  xkbVariant = "";
};

# Configure console keymap
console.keyMap = "us";

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.leo = {
  isNormalUser = true;
  description = "leo";
  extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" ];
  shell = pkgs.fish;
  packages = with pkgs; [];
};

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# AutoUpdate
system.autoUpgrade = {
  enable = true;
  channel = "https://nixos.org/channels/nixos-23.05";
};

# Garbage managment and Flakes
nix = {
  settings.auto-optimise-store = true;
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  package = pkgs.nixFlakes;
  extraOptions = "experimental-features = nix-command flakes";
};


# Logind
services.logind.extraConfig = ''
# don’t shutdown when power button is short-pressed
HandlePowerKey=ignore
'';

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "23.05"; # Did you read the comment?
}
