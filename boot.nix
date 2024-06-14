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
    initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/bc3364ae-b704-4066-923b-e5d27bba867a";
  };

  boot.consoleLogLevel = 0;

  powerManagement.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };

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
