{
  imports = [
    ./audio.nix
    ./boot.nix # boot settings
    ./enable.nix # services and special pkgs
    ./environment.nix # environment settings IMPORTANT
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ./home.nix # Home Manager
    ./my-pkgs # custom pkgs
    ./network.nix # very important
    ./nixConfig.nix # nix settings
    ./pkgs.nix # installed pkgs
    ./services # enabled services
    ./suspend-and-hibernate.nix # self explanatory
    ./sway.nix # all sway configs
    ./user.nix # user settings
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
