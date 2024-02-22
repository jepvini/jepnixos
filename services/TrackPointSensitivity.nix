{
  config,
  pkgs,
  ...
}: {
  # Trackpoint sensibility
  systemd.services.TrackpointSensibility = {
    path = [
      pkgs.bash
      pkgs.busybox
    ];
    enable = true;
    description = "Set trackpoint sensibility";
    after = ["multi-user.target"];
    startLimitBurst = 0;
    wantedBy = ["multi-user.target"];
    restartIfChanged = true;
    serviceConfig = {
      RuntimeDirectory = "TrackpointSensitivity";
      RootDirectory = "/run/TrackpointSensitivity";
      BindReadOnlyPaths = [
        "/"
      ];
      Restart = "on-failure";
      RestartSec = 30;
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '/etc/services/TrackpointSensitivity.sh'";
    };
  };

  environment.etc.trackpoint = {
    target = "services/TrackpointSensitivity.sh";
    text = ''
      echo 80 | tee $(find -L /sys/class/input/ -maxdepth 2 -name name -exec grep -l Elan {} \; 2>/dev/null | sed 's/name//')device/sensitivity
    '';
    mode = "0755";
  };
}
