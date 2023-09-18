# /etc/nixos/pkgs/gtk-theme.nix

# These are the inputs to our function (yes, this is a function).
#
# `callPackage` will automatically fill in these arguments with
# anything that is available in `pkgs`, so that includes all packages,
# as well as some build utilities and library functions.
{
  stdenvNoCC,
  fetchFromGitHub,
  gtk-engine-murrine,
  gnome-themes-extra,
}:
# This function (stdenvNoCC.mkDerivation) is the "build a package for
# me please" function from nixpkgs.
#
# It's an enhanced version of a nix builtin function for building
# derivations (read: packages), and provides some basic utilities that
# you usually need (e.g. `cp` and `mkdir`).
#
# I'm using the NoCC variant of stdenv, which doesn't include a C
# compiler, and therefore takes less time to download.
stdenvNoCC.mkDerivation {
  # Just the package name, this is used for the file name in
  # `/nix/store` and primarily useful for debugging or displaying
  # info. It's also mandatory.
  pname = "kanagawa-gkt-theme";
  # The version of the package; In this case, the project isn't
  # versioned, so the recommended practice is to use unstable-<date>.
  version = "unstable-2023-04-07";

  # This downloads the theme directly from GitHub instead of the
  # distribution site you linked.
  #
  # While I feel a bit guilty about it, because this doesn't tick the
  # donation thing, the distribution site doesn't seem to maintain
  # permalinks and therefore the hash will randomly change, which will
  # cause you headaches.
  #
  # That site also very likely tries to prevent automated downloads,
  # since those won't create ad revenue, so it'd be a headache
  # anyway. Downloading the theme directly from GitHub works better
  # for this.
  #
  # If you like the theme enough, I'd suggest doing a direct donation
  # somehow.
  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Kanagawa-GKT-Theme";
    # This is the commit of the theme we download.
    rev = "35936a1e3bbd329339991b29725fc1f67f192c1e";
    # Nix will check this hash every time it downloads the theme, to make sure GitHub has not
    # sent you a virus instead of the theme (or that the download has not somehow become
    # corrupted).
    hash = "sha256-BZRmjVas8q6zsYbXFk4bCk5Ec/3liy9PQ8fqFGHAXe0=";
  };

  # This theme uses the murrine engine, so we need to add it here.
  propagatedUserEnvPkgs = [gtk-engine-murrine gnome-themes-extra];

  # This is the actual process for "installing" the files into the
  # package. It's basically just a bash script.
  installPhase = ''
    # 1. We create the $out directory, which is where nix will pick up our
    #    package contents from.
    # 2. We then copy the GTK theme into the directory it belongs in
    #   - I also rename the directory so it doesn't have spaces in
    #     it, figure that will cause issues. The zip from that
    #     distribution site you linked to does the same.
    mkdir -p $out/share/themes/
    ls
    ls themes
    cp --archive themes/Kanagawa-B $out/share/themes/Kanagawa-B
  '';
}
