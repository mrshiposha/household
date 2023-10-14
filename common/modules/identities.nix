{ config, lib, pkgs, ... }:
let
    cfg = config.identities;

    normalUserOpts = { config, name, ... }: {
        options = {
            description = lib.mkOption {
                type = lib.types.str;
            };
            initialPassword = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
            };
        };
    };

    systemUserOpts = { config, name, ... }: {
        options = {
            description = lib.mkOption {
                type = lib.types.str;
            };
            primaryGroup = lib.mkOption {
                type = lib.types.str;
            };
        };
    };

    groupOpts = { config, name, ... }: {
        options = {
            members = lib.mkOption {
                type = with lib.types; listOf str;  
            };
        };
    };
in {
    options.identities = {
        users.normal = lib.mkOption {
            default = {};
            type = with lib.types; attrsOf (submodule normalUserOpts);
        };

        users.system = lib.mkOption {
            default = {};
            type = with lib.types; attrsOf (submodule systemUserOpts);
        };

        groups = lib.mkOption {
            default = {};
            type = with lib.types; attrsOf (submodule groupOpts);
        };
    };

    config = {
        users = {
            users = lib.mkMerge [
                (
                    lib.mapAttrs (_: usercfg: {
                        description = usercfg.description;
                        initialPassword = usercfg.initialPassword;
                        isNormalUser = true;
                    }) cfg.users.normal
                )

                (
                    lib.mapAttrs (_: usercfg: {
                        description = usercfg.description;
                        group = usercfg.primaryGroup;
                        isSystemUser = true;
                    }) cfg.users.system
                )
            ];

            groups = cfg.groups;
        };
    };
}
