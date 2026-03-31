{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.xplr.enable = mkEnableOption "xplr";

  config = mkIf config.xplr.enable {
    home.packages = with pkgs; [ exiftool ];
    programs.xplr = {
      enable = true;
      extraConfig = ''
        for name, mode in pairs(xplr.config.modes.builtin) do
          if mode.layout == "HelpMenu" then
            mode.layout = nil
          end
        end
      '';
    };
  };
}
