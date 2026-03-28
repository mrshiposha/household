{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.types;
{
  options.chromium = {
    enable = mkEnableOption "chromium";
  };

  config = mkIf config.chromium.enable {
    programs.chromium = {
      enable = true;
    };
  };
}
