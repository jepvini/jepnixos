# /etc/nixos/my-pkgs/nofetch/nofetch.nix

# These are the inputs to our function (yes, this is a function).
#
# `callPackage` will automatically fill in these arguments with
# anything that is available in `pkgs`, so that includes all packages,
# as well as some build utilities and library functions.
{
  stdenvNoCC,
  fetchFromGitHub,
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
  pname = "nofetch";
  # The version of the package; In this case, the project isn't
  # versioned, so the recommended practice is to use unstable-<date>.
  version = "1.0";

  src = fetchFromGitHub {
    owner = "leo1359531";
    repo = "nofetch";
  #   # This is the commit of the theme we download.
    rev = "c02c95c73dbd5ff3d027cd6228a5acba1c71f7bc";
  #   # Nix will check this hash every time it downloads the pkg, to make sure GitHub has not
  #   # sent you a virus instead of the theme (or that the download has not somehow become
  #   # corrupted).
    hash = "sha256-CPeWXNxZQYUWEIJ5Ip2TV7pTHFzEYEo+VFudRnaISTY=";
  };

  # This is the actual process for "installing" the files into the
  # package. It's basically just a bash script.
  installPhase = ''
    # 1. We create the $out directory, which is where nix will pick up our
    #    package contents from.
    # 2. We then copy the script into the directory it belongs in
    #   - I also rename the directory so it doesn't have spaces in
    #     it, figure that will cause issues. The zip from that
    #     distribution site you linked to does the same.
    mkdir -p $out/bin
    chmod +x nofetch
    cp 'nofetch' $out/bin/nofetch
  '';
}
