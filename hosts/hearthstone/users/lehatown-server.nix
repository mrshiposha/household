{ household, ... }:
let user = "lehatown-server";
in {
  users.users.${user} = {
    useDefaultShell = true;
    group = user;
    isNormalUser = true;
  };
  users.groups.${user} = { };

  home-managers.users.${user} = {
    imports = [ household.modules.user ];

    lehatown.enable = true;
  };
}
