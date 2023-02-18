let root = ./..; in {
  imports = [
    "${root}/bootloader.nix"
    "${root}/kernel.nix"
    "${root}/system.nix"
    "${root}/timezone.nix"
    "${root}/shell.nix"
    "${root}/dev-related.nix"
    "${root}/users.nix"
    "${root}/home-manager.nix"
  ];

  networking.hostName = "hearthstone";
  users.mutableUsers = false;
}
