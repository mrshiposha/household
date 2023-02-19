let 
  root = ./../..;
  host = "hearthstone";
in {
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
    (import "${root}/home-manager.nix" host)
  ];

  networking.hostName = host;
  users.mutableUsers = false;
}
