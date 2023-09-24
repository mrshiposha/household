{ config, lib, ... }:
let 
  root = ./../..;
  host = "hearthstone";
  resolution = "2560x1440";
  greeterImage = "${root}/common/images/${resolution}/mountain-range.jpg";
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
    "${root}/ssh.nix"
    "${root}/security.nix"
    (
      import "${root}/net" {
        vpnExternalIface = "eno1";
      }
    )
    "${root}/docker.nix"
    "${root}/unfree-pkgs.nix"
    "${root}/3d-graphics.nix"
    "${root}/greeter.nix"
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

  greeter = {
    enable = true;
    backgroundImage = greeterImage;
  };

  environment.sessionVariables = {
    SWAYLOCK_IMAGE = greeterImage;
  };

  networking.hostName = host;
  system.nixos.label = lib.mkForce "single-seat:${config.system.stateVersion}";

  specialisation = {
    multi-seat.configuration = {
      imports = [
        ./multiseat/udev/video.nix
      ];
    };
  };
}
