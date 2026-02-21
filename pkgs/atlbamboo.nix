{
  fetchurl,
  jre,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "atlbamboo";
  version = "12.1.2";

  src = fetchurl {
    url = "https://product-downloads.atlassian.com/software/bamboo/downloads/atlassian-bamboo-${finalAttrs.version}.tar.gz";
    hash = "sha256-KI2f8jE3kt8JcC2HrXNAVv6ZCrqns668iCxxTxDQOYA=";
  };

  installPhase = ''
    mkdir $out
    mv * $out
  '';

  meta = {
    homepage = "https://www.atlassian.com/software/bamboo";
    description = "Bamboo is a continuous integration and delivery tool that ties automated builds, tests, and releases into a single workflow";
    platforms = jre.meta.platforms;
    maintainers = [];
    license = lib.licenses.unfree;
  };
})

