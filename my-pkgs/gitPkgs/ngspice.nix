{
  lib,
  stdenv,
  fetchurl,
  bison,
  flex,
  readline,
  libX11,
  libICE,
  libXaw,
  libXmu,
  libXext,
  libXt,
  fftw,
}:
stdenv.mkDerivation rec {
  pname = "ngspice";
  version = "37";

  src = fetchurl {
    url = "mirror://sourceforge/ngspice/ngspice-${version}.tar.gz";
    sha256 = "1gpcic6b6xk3g4956jcsqljf33kj5g43cahmydq6m8rn39sadvlv";
  };

  nativeBuildInputs = [flex bison];
  buildInputs = [readline libX11 libICE libXaw libXmu libXext libXt fftw];

  configureFlags = ["--with-x" "--enable-xspice" "--enable-cider" "--with-readline=yes" "--enable-openmp" "--disable-debug"];

  meta = with lib; {
    description = "The Next Generation Spice (Electronic Circuit Simulator)";
    homepage = "http://ngspice.sourceforge.net";
    license = with licenses; ["BSD" gpl2];
    maintainers = with maintainers; [bgamari rongcuid];
    platforms = platforms.unix;
  };
}
