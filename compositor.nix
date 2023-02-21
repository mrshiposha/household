{config, pkgs, ...}: let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  hyprland = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  }).defaultNix;
in {
  imports = [hyprland.nixosModules.default];

  programs.hyprland = {
    enable = true;

    package = hyprland.packages.${pkgs.system}.default;

    xwayland = {
      enable = true;
      hidpi = true;
    };

    nvidiaPatches = false;
  };

  environment.sessionVariables = if config.virtualisation.virtualbox.guest.enable then {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  } else {};

  environment.systemPackages = [ wofi ];
}
