{ config, lib, ... }:
with builtins;
with lib;
with lib.types;
with lib.attrsets;

let
    cfg = config.security.poly;

    # <service>.text has a (computed) default value,
    # we don't want to overwrite it.
    # Also, session-related stuff should go at the end of the text.
    #
    # TODO: use <service>.rules instead
    # when this options stops being experimental.
    pamNamespaceRequired = mkDefault (
        mkAfter "session required pam_namespace.so\n"
    );
in {
    options.security.poly = {
        enable = mkOption {
            type = bool;
            default = false;
        };

        services = mkOption {
            type = listOf str;
        };

        instances = mkOption {
            type = attrsOf (submodule {
                options = {
                    mount = mkOption {
                        type = path;
                    };

                    type = mkOption {
                        type = enum [
                            "tmpfs"
                            "tmpdir"
                            "user"
                        ];
                    };

                    ignoreFor = mkOption {
                        type = listOf str;
                        default = [ "root" ];
                    };
                };
            });
        };
    };

    config = mkIf cfg.enable {
        systemd.tmpfiles.rules = [
            "d /poly 000 root root -"
        ];

        security.pam.services = listToAttrs
            (map
                (service: {
                    name = service;
                    value = {
                        text = pamNamespaceRequired;
                    };
                })
                cfg.services
            );

        environment.etc = {
            "security/namespace.conf".text =
                concatStringsSep "" (
                    mapAttrsToList
                        (instanceName: options: let
                            instance = lib.path.append /poly instanceName;
                            ignoreFor = concatStringsSep "," options.ignoreFor;
                        in "${toString options.mount}    ${toString instance}    ${options.type}    ${ignoreFor}\n")
                        cfg.instances
                );
        };
    };
}
