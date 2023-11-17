{
  config,
  pkgs,
  ...
}: {
  # Home backup
  systemd = {
    timers.homebk = {
      wantedBy = ["timers.target"];
      after = ["multi-user.target"];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "1h";
        Unit = "homebk.service";
      };
    };

    services.homebk = {
      path = [
        pkgs.bash
        pkgs.busybox
        pkgs.rclone
        pkgs.libnotify
      ];
      description = "home bk with rclone and nextcloud";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        User = "leo";
        Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
        Restart = "on-failure";
        RestartSec = 30;
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '/home/leo/.config/bin/home-bk'";
      };
    };
  };
}
