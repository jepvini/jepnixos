{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
# I'm using the NoCC variant of stdenv, which doesn't include a C
# compiler, and therefore takes less time to download.
stdenvNoCC.mkDerivation {
  pname = "setPL";
  version = "1.16";

  src = fetchFromGitHub {
    owner = "jepvini";
    repo = "setPL";
    #   # This is the commit of the theme we download.
    rev = "57668174ba53243206eea768e1d6ac132d447f59";
    #   # Nix will check this hash every time it downloads the pkg, to make sure GitHub has not
    #   # sent you a virus instead of the theme (or that the download has not somehow become
    #   # corrupted).
    hash = "sha256-e3Yh/qaD7Sn2QPznRK1TaDCqshcqIS5/5o9l/wID9gY=";
  };

  # This is the actual process for "installing" the files into the
  # package. It's basically just a bash script.
  installPhase = ''
    mkdir -p $out/bin
    chmod +x setPL.sh
    cp 'setPL.sh' $out/bin/setPL
  '';

  meta = with lib; {
    description = "Linux script for setting the PL1/PL2 power limits on modern Intel processors";
    homepage = "https://github.com/horshack-dpreview/setPL";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    maintainers = with maintainers; [jepvini];
    mainProgram = "setPL";
  };
}
