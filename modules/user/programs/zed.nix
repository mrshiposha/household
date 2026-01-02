{
  config,
  lib,
  ...
}:
with lib;
with types;
{
  options.zed.enable = mkEnableOption "Zed Editor";

  config = mkIf config.zed.enable {
    programs.zed-editor = {
      enable = true;
      userSettings = {
        features = {
          copilot = false;
        };
        telemetry = {
          metrics = false;
          diagnostics = false;
        };
        vim_mode = true;
        base_keymap = "VSCode";
        thene = {
          mode = "dark";
          light = "Gruvbox Light";
          dark = "One Dark";
        };
        disable_ai = true;
      };
    };
  };
}
