{ household, ... }:
let uid = 1000;
in {
  users.users.mrshiposha = {
    isNormalUser = true;
    inherit uid;
    description = "Daniel Shiposha";
    extraGroups = [ "wheel" "podman" "wireshark" ];
  };
  gui.games.mountSharedLibraryFor = [{
    ownerName = "mrshiposha";
    ownerId = uid;
    groupId = household.usersGid;
  }];

  home-manager.users.mrshiposha = {
    imports = [ household.modules.user ];

    theming.gui.wallpapers = {
      active = household.image /1920x1080/nord_mountains.png;
      screensaver = household.image /1920x1080/nord_waves.png;
    };

    preset.mrshiposha = {
      enable = true;
      devEmail = true;
    };
    stats.batsignal = true;
  };
}
