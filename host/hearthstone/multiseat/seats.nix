pkgs: { config, name, lib, ... }: with lib; {
    options = {
        devices = mkOption {
            type = types.listOf types.attrs;
            default = [];
        };

        rules = mkOption {
            type = types.path;
        };
    };

    config = let ruleFile = "15-${name}-seat.rules"; in {
        rules = pkgs.writeTextFile {
            name = ruleFile;
            text = strings.concatStrings (
                    builtins.map (device: ''
                        SUBSYSTEM=="${device.subsystem}", KERNEL=="${device.name}", ENV{ID_SEAT}="${name}"
                    ''
                ) config.devices
            );
            destination = "/etc/udev/rules.d/${ruleFile}";
        };
    };
}
