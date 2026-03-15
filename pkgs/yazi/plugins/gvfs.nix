{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "gvfs.yazi";
  version = "0-unstable-2026-02-16";

  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "gvfs.yazi";
    rev = "9d64595cd5ba669dda27d41a936e748a795e949a";
    hash = "sha256-KXx0SDcksaA7cM7UonUGVtm1JJEyC1lGja3R+fsHxtY=";
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
