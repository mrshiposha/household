let 
  root = ./../..;
  host = "hearthstone";
  resolution = "2560x1440";
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
    "${root}/polkit.nix"
    "${root}/docker.nix"
    "${root}/unfree-pkgs.nix"
    "${root}/3d-graphics.nix"
    (import "${root}/displaymanager.nix" resolution)
    "${root}/users.nix"
    (import "${root}/home-manager.nix" host)
    "${root}/compositor.nix"
    "${root}/widgets.nix"
    "${root}/file-manager.nix"
    "${root}/audio.nix"
    "${root}/bluetooth.nix"
    "${root}/openrgb.nix"
    "${root}/games.nix"
  ];

  boot.kernelModules = [ "amdgpu" ];

  environment.sessionVariables = {
    SWAYLOCK_IMAGE = "${root}/common/images/${resolution}/mountain-range.jpg";
  };

  networking.hostName = host;
}
