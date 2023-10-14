{ pkgs, ... }: with pkgs; {
    hardware.opengl = {
        extraPackages = [
            rocm-runtime
            rocm-opencl-icd
            rocm-opencl-runtime
        ];
        driSupport = true;
        driSupport32Bit = true;
    };

    systemd.tmpfiles.rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
    ];

    environment.systemPackages = [
        corectrl
        rocminfo
    ];
}
