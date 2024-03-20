{
  config,
  pkgs,
  ...
}: {
  # bootloader
  boot = {
    initrd.kernelModules = [];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 5; # Limits entry number
    };
    # plymouth.enable = true;
    # plymouth.theme = "breeze";
  };

  # mandatory for zfs
  networking.hostId = "de1b697d";

  # Use latest kernel with zfs support
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  services.zfs.autoScrub.enable = true; # auto scrub zfs
  boot.kernelParams = ["nohibernate" "quiet"];
  # boot.kernelParams = ["nohibernate" "quiet" "zfs.zfs_arc_max=17179869184"];
  boot.consoleLogLevel = 0;

  # login manager
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
