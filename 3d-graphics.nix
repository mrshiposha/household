{ pkgs, ... }: with pkgs; {
    hardware.opengl = {
        extraPackages = [
            rocm-opencl-icd
            rocm-opencl-runtime
        ];
        driSupport = true;
        driSupport32Bit = true;
    };
}
