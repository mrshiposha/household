{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.emacs.enable = mkEnableOption "emacs";

  config.programs.emacs = {
    enable = config.emacs.enable;
    package = pkgs.emacs-pgtk;
    extraPackages =
      epkgs: with epkgs; [
        nord-theme
      ];
    extraConfig = ''
      (custom-set-variables
       '(custom-enabled-themes '(nord))
        '(custom-safe-themes
           '("7addbdeb9a444444c3114f228808c398eff733b0bd6e3050469b46f4d88c55d6"
             default)))
    '';
  };
}
