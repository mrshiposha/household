{ config, pkgs, name, lib, ... }: 
let
    seats = (import ./seats.nix pkgs);
in with lib; {
    options = {
        extraSeats = mkOption {
            type = types.attrsOf (types.submodule seats);
        };

        driPrime = mkOption {
            type = types.str;
            default = "0";
        };
    };

    config = {
        system.nixos.tags = ["multiseat"];

        services.udev.packages = builtins.attrValues (
            builtins.mapAttrs (_: extraSeat: extraSeat.rules) config.extraSeats
        );

        greeter.extraSeats = builtins.attrNames config.extraSeats;

        environment.sessionVariables.DRI_PRIME = config.driPrime;
    };
}
