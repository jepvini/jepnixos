{ lib, stdenv, fetchFromGitHub, ncurses }:

stdenv.mkDerivation rec {
  pname = "sl";
  version = "5.5";

  src = fetchFromGitHub {
    owner = "leo1359531";
    repo = "fast-sl";
    rev = "fc26e340942bf101d66df94cada665f6eade2a69";
    sha256 = "sha256-n0uLu7s6LtmxVGoPxgbe+gxI12RJrzgSt4ubhaMBJ48=";
  };

  buildInputs = [ ncurses ];

  makeFlags = [ "CC:=$(CC)" ];

  installPhase = ''
    runHook preInstall

    install -Dm755 -t $out/bin sl
    install -Dm644 -t $out/share/man/man1 sl.1{,.ja}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Steam Locomotive runs across your terminal when you type 'sl'";
    maintainers = with maintainers; [ jep ];
    platforms = platforms.unix;
  };
}
