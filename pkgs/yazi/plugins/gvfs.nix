{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "gvfs.yazi";
  version = "0-unstable-2026-03-29";

  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "gvfs.yazi";
    rev = "3abc0a258f9d7aeaa453a2d0d6e103c5a305953d";
    hash = "sha256-UHneVJ+YXyDuPrZS+PZbs9n9h+VN5M2QG36FdprBkJc=";
  };

  installPhase = ''
    mkdir -p $out

    cp -r * $out/

    rm -f $out/*.md
    rm -f $out/.luarc.json
    rm -f $out/assets/gnome-keyring-daemon.service
  '';

  meta = {
    description = "Transparently mount and unmount devices in read/write mode";
    homepage = "https://github.com/boydaihungst/gvfs.yazi";
    license = lib.licenses.mit;
    maintainers = [];
  };
}
