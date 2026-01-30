{
  config,
  fetchFromGitHub,
  lib,
  pkgs,
  stdenvNoCC,
  themeConfig ? null,
}:

let
  bgFileName = if themeConfig.General.background != null then lib.builtins.baseNameOf themeConfig.General.background else "noctalia.png";
  bgFinalConfigValue = "Assets/Wallpaper/${bgFileName}";
  finalThemeConfig = if themeConfig != null then themeConfig.override { General.background = bgFinalConfigValue; } else null;
in
  stdenvNoCC.mkDerivation rec {
    pname = "sddm-noctalia";
    version = "unstable-2026-01-23";

    src = fetchFromGitHub {
      owner = "ClementFombonne";
      repo = "sddm-noctalia-theme";
      rev = "92bf8e6ff35be19b50b60a38e0f3d6e38e1c66e1";
      hash = "sha256-crN2oqml/QJTjOCa3/i0MQREDvPzg5TYC5BfKnk77fQ=";
    };

    propagatedBuildInputs = with pkgs.kdePackages; [
      qt6ct
      qtsvg
      qtwayland
      qtdeclarative
    ];

    dontWrapQtApps = true;

    installPhase = ''
      mkdir -p $out/share/sddm/themes/noctalia
      cp -r * $out/share/sddm/themes/noctalia

      rm -fr $out/share/sddm/themes/noctalia/flake.*
      rm -fr $out/share/sddm/themes/noctalia/*.sh
      rm -fr $out/share/sddm/themes/noctalia/*.md
      rm -fr $out/share/sddm/themes/noctalia/nix

      # --- HANDLE CUSTOM BACKGROUND ---
      # Only run this block if the user provided a background path
      ${lib.optionalString (themeConfig != null) ''
        mkdir -p $out/share/sddm/themes/noctalia/Assets/Wallpaper
        cp ${themeConfig.General.background} $out/share/sddm/themes/noctalia/Assets/Wallpaper/${bgFileName}
      ''}

      ${lib.optionalString (finalThemeConfig != null) ''
        rm -f $out/share/sddm/themes/noctalia/Commons/Settings.conf
        cp ${pkgs.writeText "theme.conf" (lib.generators.toINI { } finalThemeConfig)} \
            $out/share/sddm/themes/noctalia/Commons/Settings.conf
      ''}
    '';

    meta = with lib; {
      description = "SDDM theme inspired by noctalia-shell lock screen";
      homepage = "https://github.com/ClementFombonne/sddm-noctalia-theme";
      license = licenses.gpl3;
      maintainers = [];
    };
  }
