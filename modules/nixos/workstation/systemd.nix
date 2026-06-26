{ ... }:

{
  config = {
    systemd.user.extraConfig = ''
        DefaultLimitNOFILE=65536:524288
    '';
  };
}
