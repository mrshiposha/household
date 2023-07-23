{ config, pkgs, ... }:
let
    name = "10-video-multiseat.rules";
    video-rules = pkgs.writeTextFile {
        name = name;
        text = ''
            ACTION=="add", SUBSYSTEM=="drm", KERNEL=="card1-DP-3", ENV{ID_SEAT}:="hall"
        '';
        destination = "/etc/udev/rules.d/${name}";
    };
in {
    system.nixos.label = "multi-seat:${config.system.stateVersion}";
    services.udev.packages = [ video-rules ];
}
