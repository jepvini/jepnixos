{
  lib,
  stdenv,
  fetchFromGitHub,
  ncurses,
}:
stdenv.mkDerivation rec {
  pname = "fast-sl";
  version = "5.5";

  src = fetchFromGitHub {
    owner = "jepvini";
    repo = "fast-sl";
    rev = "4903ab82dbe0f080b5caaf51fa3bd1ec9e7eb3ff";
    sha256 = "sha256-cmNSPZl3o0XC0qmDT/HviBsETOyGnPmqJFlKLe1DQJc=";
  };

  buildInputs = [ncurses];

  makeFlags = ["CC:=$(CC)"];

  installPhase = ''
    runHook preInstall

    install -Dm755 -t $out/bin fast-sl

    runHook postInstall
  '';

  meta = with lib; {
    description = "Fast sl, as normal sl but faster";
    maintainers = with maintainers; [jep];
    platforms = platforms.unix;
  };
}
