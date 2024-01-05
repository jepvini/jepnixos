{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
# I'm using the NoCC variant of stdenv, which doesn't include a C
# compiler, and therefore takes less time to download.
stdenvNoCC.mkDerivation {
  pname = "setmap";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "jepvini";
    repo = "jepmap";
    #   # This is the commit of the theme we download.
    rev = "475cddfa939d8f3b98f7204369624d4814e1a9eb";
    #   # Nix will check this hash every time it downloads the pkg, to make sure GitHub has not
    #   # sent you a virus instead of the theme (or that the download has not somehow become
    #   # corrupted).
    hash = "sha256-KLvo60QXW2H+q9+Gk8dIJu6Ri0pFDjBq79JdNIktd+o=";
  };

  # This is the actual process for "installing" the files into the
  # package. It's basically just a bash script.
  installPhase = ''
    mkdir -p $out/bin
    chmod +x jepmap
    cp 'jepmap' $out/bin/jepmap
  '';

  meta = with lib; {
    description = "a simple bash script to set and monitor the power settings of your cpu";
    homepage = "https://github.com/jepvini/jepmap";
    platforms = platforms.all;
    maintainers = with maintainers; [jepvini];
    mainProgram = "jepmap";
  };
}
