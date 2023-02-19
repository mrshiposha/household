let root = ./..; in {
  imports = [
    (
      import "${root}/boot.nix" {
        silentBoot = true;
        resolution = "1920x1080";
      }
    )
    "${root}/kernel.nix"
    "${root}/system.nix"
    "${root}/timezone.nix"
    "${root}/shell.nix"
    "${root}/base-sysenv.nix"
    "${root}/users.nix"
    "${root}/home-manager.nix"
  ];

  networking.hostName = "hearthstone";
  users.mutableUsers = false;
}
