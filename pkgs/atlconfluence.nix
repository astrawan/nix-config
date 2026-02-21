{
  fetchurl,
  jre,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "atlconfluence";
  version = "10.2.6";

  src = fetchurl {
    url = "https://product-downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-${finalAttrs.version}.tar.gz";
    hash = "sha256-S2r3nA/JXDx6ZXDELiGtuEE4Oo0MC8jinb0k1czjWXE=";
  };

  installPhase = ''
    mkdir $out
    mv * $out
  '';

  meta = {
    homepage = "https://www.atlassian.com/software/confluence";
    description = "Confluence is where you create, organize, and discuss work with your team";
    platforms = jre.meta.platforms;
    maintainers = [];
    license = lib.licenses.unfree;
  };
})

