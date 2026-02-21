{
  fetchurl,
  jre,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "atlcrowd";
  version = "7.1.4";

  src = fetchurl {
    url = "https://product-downloads.atlassian.com/software/crowd/downloads/atlassian-crowd-${finalAttrs.version}.tar.gz";
    hash = "sha256-eQAkg2fI3Yz4yCqx1TqsdCaqyEhtES6ogccRPneXY4A=";
  };

  installPhase = ''
    mkdir $out
    mv * $out
  '';

  meta = {
    homepage = "https://www.atlassian.com/software/crowd";
    description = "Manage users from multiple directories - Active Directory, LDAP, Crowd - via a single admin console, and control application permissions from the same place";
    platforms = jre.meta.platforms;
    maintainers = [];
    license = lib.licenses.unfree;
  };
})

