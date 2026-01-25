{ config, ... }:

{
  users.users.${config.devlive.user.name} = {
    description = "${config.devlive.user.fullName}";
    packages = config.devlive.user.packages;
  };
}
