{ config, pkgs, lib, ... }:
with lib; {
  options.helix.enable = mkEnableOption "helix editor";

  config.programs.helix = {
    enable = config.helix.enable;
    defaultEditor = true;
    settings = {
      theme = "nord_transparent";
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker.hidden = false;
        whitespace.render = "all";
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
    themes = {
      nord_transparent = {
        "inherits" = "nord";
        "ui.background" = { };
      };
    };
  };
}
