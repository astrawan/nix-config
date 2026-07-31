{
  lib,
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  stdenv,
  cargo-about,
}:
rustPlatform.buildRustPackage rec {
  pname = "notema";
  version = "2026.7.8";

  src = fetchFromGitHub {
    owner = "paviro";
    repo = "Notema";
    rev = "${version}";
    sha256 = "sha256-CUsfq1jnG0TZWbhLqN3JvgqMA9bQpD9UQaOpBlYj5fs=";
  };

  RUST_TOOLCHAIN = "stable";
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "notema-textarea-0.9.2" = "sha256-X73lKNgm/hIDSyqwI5Up8Iz6sVxuW77ixoWPOKI+ucI=";
    };
  };

  doCheck = false;
  doInstallCheck = true;

  nativeBuildInputs = [
    installShellFiles
    cargo-about
  ];

  patchPhase = ''
    runHook prePatch

    RUST_VERSION="$(rustc --version | awk -F' ' '{print $2}')"
    substituteInPlace rust-toolchain.toml \
      --replace 'channel = "1.96.0"' "channel = \"$RUST_VERSION\""
    substituteInPlace Cargo.toml \
      --replace 'rust-version = "1.96.0"' "rust-version = \"$RUST_VERSION\""

    runHook postPatch
  '';

  postInstall = lib.optionalString stdenv.hostPlatform.isLinux ''
    mkdir -p $out/share/applications
    cat > $out/share/applications/notema.desktop <<'EOF'
    [Desktop Entry]
    Type=Application
    Name=Notema
    Exec=notema
    Categories=Utility;
    Terminal=true
    EOF
  '';

  meta = with lib; {
    description = "A terminal-based Markdown journaling app";
    mainProgram = "notema";
    homePage = "https://github.com/paviro/Notema";
    license = licenses.eupl12;
    maintainers = [ ];
  };
}
