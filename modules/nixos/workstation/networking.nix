{
  pkgs,
  ...
}:

{
  config = {
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.enableIPv6 = false;
    boot.kernel.sysctl = {
      "net.ipv6.conf.all.disable_ipv6" = 1;
      "net.ipv6.conf.default.disable_ipv6" = 1;
      "net.ipv6.conf.lo.disable_ipv6" = 1;
    };
    networking.networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
        networkmanager-fortisslvpn
      ];
    };
    networking.extraHosts = ''
      127.0.0.1 development.local
      127.0.0.1 idm.development.local
      127.0.0.1 devcontainer.development.local
    '';

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall = {
      enable = true;
      allowPing = false;
      # kde-connect
      allowedTCPPortRanges = [ ];
      allowedUDPPortRanges = [ ];
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
      checkReversePath = "loose";
      # extraCommands = '''';
      # extraStopCommands = '''';
      interfaces = {
        # virtualisation NAT interface
        virbr0 = {
          allowedTCPPorts = [
            22
            5173
            5432
            6379
            8080
          ];
        };
      };
    };
  };
}
