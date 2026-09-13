{
  config,
  pkgs,
  ...
}:

{
  networking.hostName = "hydra";

  # Set your time zone.
  time.timeZone = "${config.devlive.host.timeZone}";

  # Select internationalisation properties.
  i18n.defaultLocale = "${config.devlive.host.defaultLocale}";

  environment.systemPackages = with pkgs; [
    git
    tmux
    vim
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [ ];
    allowedUDPPortRanges = [ ];
    allowedTCPPorts = [ 3000 ];
    allowedUDPPorts = [ ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.hydra = {
    enable = true;
    dbi = "dbi:Pg:host=pgsql15.vm;port=5432;dbname=hydra;user=hydra";
    hydraURL = "hydra.stack.devlive.cloud"; # externally visible URL
    notificationSender = "hydra@localhost"; # e-mail of Hydra service
    # a standalone Hydra will require you to unset the buildMachinesFiles list to avoid using a nonexistant /etc/nix/machines
    buildMachinesFiles = [ ];
    # you will probably also want this, otherwise *everything* will be built from scratch
    useSubstitutes = true;
  };

  nix.buildMachines = [
    {
      hostName = "localhost";
      systems = [
        "x86_64-linux"
      ];
      maxJobs = 1;
      # for building VirtualBox VMs as build artifacts, you might need other
      # features depending on what you are doing
      supportedFeatures = [ ];
    }
  ];
  nix.gc = {
    automatic = true;
    dates = "15 3 * * *";
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.cores = 22;
  nix.settings.max-jobs = 11;
  nix.settings.trusted-users = [
    "hydra"
    "hydra-evaluator"
    "hydra-queue-runner"
  ];

  system.stateVersion = "26.05";
}
