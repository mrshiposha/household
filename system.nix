{ config, pkgs, ... }: {
  system.stateVersion = import "./functions/system-version.nix";
}
