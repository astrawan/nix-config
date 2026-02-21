{
  fetchurl,
  jre,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "atlbitbucket";
  version = "10.1.5";

  src = fetchurl {
    url = "https://product-downloads.atlassian.com/software/stash/downloads/atlassian-bitbucket-${finalAttrs.version}.tar.gz";
    hash = "sha256-oxieMVyQvRFdu/kSW4LDWp8LJqINLbOog3KIl8XmOgY=";
  };

  installPhase = ''
    mkdir $out
    mv * $out
  '';

  meta = {
    homepage = "https://www.atlassian.com/software/bitbucket";
    description = "Bitbucket is self-hosted Git repository collaboration and management for professional teams";
    platforms = jre.meta.platforms;
    maintainers = [];
    license = lib.licenses.unfree;
  };
})

