{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.lxc.services.atlcrowd;
  atlcrowd = pkgs.atlcrowd;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.atlcrowd ];

    users.groups."${cfg.group}".gid = config.ids.gids.tomcat;

    users.users."${cfg.user}" = {
      uid = config.ids.uids.tomcat;
      description = "crowd user";
      home = "${cfg.dataDir}";
      group = "${cfg.group}";
      extraGroups = cfg.extraGroups;
    };

    systemd.services.atlcrowd = {
      description = "";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      # preStart = ''
      # '';

      serviceConfig = {
        Type = "forking";
        PermissionStartOnly = true;
        PIDFile = "${cfg.dataDir}/catalina.pid";
        RuntimeDirectory = "tomcat";
        User = cfg.user;
        Environment = [
          # "CATALINA_BASE=${cfg.baseDir}"
          "CATALINA_PID=${cfg.dataDir}/catalina.pid"
          "CATALINA_OPTS='${toString cfg.catalinaOpts}'"
          "CATALINA_OUT='${cfg.dataDir}/logs/catalina.out'"
          "CATALINA_TEMP='${cfg.dataDir}/temp'"
          "JAVA_HOME='${cfg.jdk}'"
          "JAVA_OPTS='${toString cfg.javaOpts}'"
        ]
        ++ cfg.extraEnvironment;
        ExecStart = "${atlcrowd}/start_crowd.sh";
        ExecStop = "${atlcrowd}/stop_crowd.sh";
      };
    };
  };
}
