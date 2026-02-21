{
  fetchurl,
  jre,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "atljira";
  version = "11.3.2";

  src = fetchurl {
    url = "https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-${finalAttrs.version}.tar.gz";
    hash = "sha256-T+XgHTx1pkzA7Du/jPVlHAouf0NX9UM8BM0DA1s3qtw=";
  };

  installPhase = ''
    mkdir $out
    mv * $out
  '';

  meta = {
    homepage = "https://www.atlassian.com/software/jira";
    description = "A one-stop-shop for administering Jira Software and Jira Service Management";
    platforms = jre.meta.platforms;
    maintainers = [];
    license = lib.licenses.unfree;
  };
})

