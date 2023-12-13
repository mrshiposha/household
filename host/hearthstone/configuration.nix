{ config, pkgs, lib, ... }:
let 
  root = ./../..;
  stateVersion = "23.11";
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
    (import "${root}/home-manager.nix" (builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${stateVersion}.tar.gz"))
    "${root}/compositor.nix"
    "${root}/widgets.nix"
    "${root}/file-manager.nix"
    "${root}/audio.nix"
    "${root}/bluetooth.nix"
    "${root}/openrgb.nix"
    "${root}/games.nix"

    "${root}/openrazer.nix"
    "${root}/common/modules/identities.nix"
  ];

  system.stateVersion = stateVersion;
  networking.hostName = "hearthstone";
  boot.kernelModules = [ "amdgpu" ];

  greeter = {
    enable = true;
    backgroundImage = greeterImage;
  };

  environment.sessionVariables = {
    SWAYLOCK_IMAGE = greeterImage;
  };

  services.hardware.bolt.enable = true;

  identities = {
    users.normal = {
      mrshiposha = {
        initialPassword = "helloworld";
        description = "Daniel Shiposha";
      };

      wally = {
        description = "Valentina Shiposha";
      };
    };

    users.system = {
      common = {
        description = "The owner of common directories";
        primaryGroup = "common";
      };
    };

    groups = {
      wheel.members = ["mrshiposha"];
      docker.members = ["mrshiposha"];
      video.members = ["mrshiposha" "wally"];
      render.members = ["mrshiposha" "wally"];
      openrazer.members = ["mrshiposha" "wally"];
      common.members = ["common" "mrshiposha" "wally"];
    };
  };

  systemd = {
    tmpfiles.rules = [
      "d /media/steam-library 2770 common common -"
    ];
  };

  specialisation = {
    multiseat.configuration = {
      imports = ["${root}/common/modules/multiseat"];

      extraSeats.seat-hall = {
        devices = [
          {
            subsystem = "drm";
            name = "card1";
          }

          {
            subsystem = "usb";
            name = "3-8.4";
          }
        ];
      };
    };
  };
}
