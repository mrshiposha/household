{ pkgs, ... }: with pkgs; {
    hardware.opengl = {
        extraPackages = [
            rocmPackages.rocm-runtime
            rocm-opencl-icd
            rocm-opencl-runtime
        ];
        driSupport = true;
        driSupport32Bit = true;
    };

    systemd.tmpfiles.rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    environment.systemPackages = [
        corectrl
        rocmPackages.clr
        rocmPackages.rocminfo
    ];
}
