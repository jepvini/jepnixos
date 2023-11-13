{
  config,
  pkgs,
  ...
}: {
  # Home backup
  systemd = {
    services.homebk = {
      path = [
        pkgs.bash
        pkgs.busybox
        pkgs.rclone
        pkgs.libnotify
      ];
      enable = true;
      description = "home bk with rclone and nextcloud";
      after = ["multi-user.target"];
      startLimitBurst = 0;
      wantedBy = ["multi-user.target"];
      restartIfChanged = true;
      serviceConfig = {
        User = "leo";
        Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
        Restart = "on-failure";
        RestartSec = 30;
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '/home/leo/.config/bin/home-bk'";
      };
    };

    timers.homebk = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "1h";
        Unit = "homebk.service";
      };
    };
  };
}
