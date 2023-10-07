{ config, pkgs, lib, ... }:
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

  services.hardware.bolt.enable = true;

  users = {
    users = {
      common = {
        description = "The owner of the common directory";
        group = "common";
        isSystemUser = true;
      };

      mrshiposha = {
        home = "/home/mrshiposha";
        initialPassword = "helloworld";
        description = "Daniel Shiposha";
        extraGroups = [ "wheel" "common" ];
        isNormalUser = true;
        openssh.authorizedKeys.keyFiles = [];
      };

      wally = {
        home = "/home/wally";
        description = "Valentina Shiposha";
        extraGroups = [ "common" ];
        isNormalUser = true;
      };
    };
    groups.common = {};
  };

  systemd = {
    tmpfiles.rules = [
      "d /media/steam-library 2770 common common -"
    ];
  };

  specialisation = {
    multi-seat.configuration = {
      imports = [./multiseat];

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
