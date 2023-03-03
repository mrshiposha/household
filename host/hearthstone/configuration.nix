let 
  root = ./../..;
  host = "hearthstone";
  resolution = "1920x1080";
in {
  imports = [
    (
      import "${root}/boot.nix" {
        silentBoot = true;
        inherit resolution;
      }
    )
    "${root}/kernel.nix"
    "${root}/system.nix"
    "${root}/timezone.nix"
    "${root}/shell.nix"
    "${root}/base-sysenv.nix"
    (import "${root}/displaymanager.nix" resolution)
    "${root}/users.nix"
    (import "${root}/home-manager.nix" host)
    "${root}/compositor.nix"
    "${root}/widgets.nix"
    "${root}/file-manager.nix"
    "${root}/audio.nix"
  ];

  networking.hostName = host;
}
