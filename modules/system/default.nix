{ pkgs, lib, ... }:
with lib; {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./net.nix
    ./gui.nix
    ./laptop.nix
    ./intel.nix
    ./audio.nix
    ./container-mgmt.nix
    ./unfree.nix
    ./services
    ./razer.nix
    ./monitoring.nix
    ./amdgpu.nix
  ];

  hardware.enableRedistributableFirmware = mkDefault true;

  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh = {
    enable = mkDefault true;
    enableCompletion = mkDefault true;
    autosuggestions.enable = mkDefault true;
  };
  users.defaultUserShell = pkgs.zsh;

  net.ssh.enable = mkDefault true;
  net.netbird.enable = mkDefault true;
}
