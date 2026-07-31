{
  fetchzip,
  gitUpdater,
  lib,
  stdenv,
}:

let
  appName = "OmniWM.app";
  version = "0.2.9";
in
stdenv.mkDerivation {
  pname = "omniwm";
  inherit version;

  src = fetchzip {
    url = "https://github.com/BarutSRB/OmniWM/releases/download/v${version}/OmniWM-v${version}.zip";
    hash = "sha256-fGBhN1RMgc2XR2SsA2eXYeMinWBGcF1wBpcqAvhr8+Q=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/Applications
    mv ../source  $out/Applications/${appName}
    ln -s $out/Applications/${appName}/Contents/MacOS/OmniWM $out/bin/omniwm

    runHook postInstall
  '';

  doInstallCheck = true;

  passthru.updateScript = gitUpdater {
    url = "https://github.com/BarutSRB/OmniWM.git";
    rev-prefix = "v";
  };

  meta = {
    license = lib.licenses.gpl2;
    mainProgram = "omniwm";
    homepage = "https://github.com/BarutSRB/OmniWM";
    description = "MacOS Niri and Hyprland inspired tiling window manager that's developer signed and notorized (safe for managed enterprise environments)";
    platforms = lib.platforms.darwin;
    maintainers = [ ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
