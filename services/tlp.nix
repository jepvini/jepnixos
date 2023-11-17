{
  config,
  pkgs,
  ...
}: {
  # Tlp
  tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;

      TLP_DEFAULT_MODE = "BAT";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_MIN_PERF_ON_AC = "0";
      CPU_MAX_PERF_ON_AC = "100";
      CPU_MIN_PERF_ON_BAT = "0";
      CPU_MAX_PERF_ON_BAT = "30";

      CPU_BOOST_ON_AC = "1";
      CPU_BOOST_ON_BAT = "0";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
    };
  };
}