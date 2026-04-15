{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.helix.enable = mkEnableOption "helix editor";

  config.programs.helix = {
    enable = config.helix.enable;
    defaultEditor = true;
    extraPackages = with pkgs; [ lldb ];
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
      keys.normal = {
        space.space = ":toggle line-number absolute relative";
      };
      keys.select = {
        space.space = ":toggle line-number absolute relative";
      };
    };
    languages = {
      language-server.deno-lsp = {
        command = "deno";
        args = [ "lsp" ];
        config.deno.enable = true;
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
        {
          name = "typescript";
          roots = [
            "deno.json"
            "deno.jsonc"
            "package.json"
          ];
          file-types = [
            "ts"
            "tsx"
          ];
          auto-format = true;
          language-servers = [ "deno-lsp" ];
        }
      ];
    };
    themes = {
      nord_transparent = {
        "inherits" = "nord";
        "ui.background" = { };
      };
    };
  };
}
