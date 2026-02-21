{
  fetchurl,
  jre,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "atlservicedesk";
  version = "11.3.2";

  src = fetchurl {
    url = "https://product-downloads.atlassian.com/software/jira/downloads/atlassian-servicedesk-${finalAttrs.version}.tar.gz";
    hash = "sha256-lp2JsG3oQCdCMIN5KvrXpwt4GAvSXER67hk9gEJHjd8=";
  };

  installPhase = ''
    mkdir $out
    mv * $out
  '';

  meta = {
    homepage = "https://www.atlassian.com/software/jira/service-management/features/service-desk";
    description = "Put the power of Jira in the hands of your service desk team";
    platforms = jre.meta.platforms;
    maintainers = [];
    license = lib.licenses.unfree;
  };
})

