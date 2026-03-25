{ config, ... }:

let
  user = config.devlive.user;
in
{
  users.users.${config.devlive.user.name} = {
    isNormalUser = true;
    description = "${user.fullName}";
    extraGroups = user.groups;
    packages = user.packages;
    uid = user.id;
  };
}
