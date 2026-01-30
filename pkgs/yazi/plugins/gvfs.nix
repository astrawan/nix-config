{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "gvfs.yazi";
  version = "0-unstable-2026-01-26";

  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "gvfs.yazi";
    rev = "30440c70affb1916a553d805a193c4b5ddab4058";
    hash = "sha256-jcNHthObhZ5OPHwBxy0Pc3udlGUaZF9WqxHeoXeFbtg=";
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
