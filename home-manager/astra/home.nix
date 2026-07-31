# vi: sw=2 ts=2 et
{
  config,
  lib,
  pkgs,
  ...
}:

let
  user = config.devlive.user;
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${user.name}";
  home.homeDirectory =
    if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${user.name}" else "/home/${user.name}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/astra/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };
  xdg.mimeApps.enable = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      commit = {
        gpgsign = true;
      };
      fetch = {
        prune = true;
      };
      tag = {
        forceSignAnnotated = true;
      };
      user = {
        signingkey = user.gpg.publicKey.id;
        email = "${user.email}";
        name = "${user.fullName}";
      };
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "localhost.1" = {
        hostname = "localhost";
        port = 8101;
        HostKeyAlgorithms = "+ssh-rsa";
      };
      "localhost.2" = {
        hostname = "localhost";
        port = 8102;
        HostKeyAlgorithms = "+ssh-rsa";
      };
      "localhost.3" = {
        hostname = "localhost";
        port = 8103;
        HostKeyAlgorithms = "+ssh-rsa";
      };
      "localhost.4" = {
        hostname = "localhost";
        port = 8104;
        HostKeyAlgorithms = "+ssh-rsa";
      };
      "localhost.5" = {
        hostname = "localhost";
        port = 8105;
        HostKeyAlgorithms = "+ssh-rsa";
      };
      "localhost.6" = {
        hostname = "localhost";
        port = 8106;
        HostKeyAlgorithms = "+ssh-rsa";
      };
    };
  };

  sops = {
    defaultSopsFile = ../../secrets/secrets.astra.yaml;
    gnupg.home = "${config.home.homeDirectory}/.gnupg";
    secrets = {
      password_jellyfin = { };
    };
  };
}
