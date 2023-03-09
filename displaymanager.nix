resolution: {pkgs, ...}:
let theme = "simplicity"; in {
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
    displayManager = {
      sddm = {
        enable = true;
        inherit theme;
      };
    };
  };

  environment.systemPackages = [
    (pkgs.callPackage ./common/packages/sddm-theme/${theme}.nix { inherit resolution; })
  ];
}
