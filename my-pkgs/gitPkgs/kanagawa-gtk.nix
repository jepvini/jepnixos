# /etc/nixos/pkgs/gtk-theme.nix
{
  stdenvNoCC,
  fetchFromGitHub,
  gtk-engine-murrine,
  gnome-themes-extra,
}:
# I'm using the NoCC variant of stdenv, which doesn't include a C
# compiler, and therefore takes less time to download.
stdenvNoCC.mkDerivation {
  pname = "kanagawa-gkt-theme";
  version = "unstable-2023-04-07";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Kanagawa-GKT-Theme";
    rev = "35936a1e3bbd329339991b29725fc1f67f192c1e";
    hash = "sha256-BZRmjVas8q6zsYbXFk4bCk5Ec/3liy9PQ8fqFGHAXe0=";
  };

  # This theme uses the murrine engine, so we need to add it here.
  propagatedUserEnvPkgs = [gtk-engine-murrine gnome-themes-extra];

  # This is the actual process for "installing" the files into the
  # package. It's basically just a bash script.
  installPhase = ''
    mkdir -p $out
    cp -r $src $out
  '';
}
