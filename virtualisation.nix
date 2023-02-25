{ config, ... }: let isEnabled = config.virtualisation.virtualbox.guest.enable; in {
  nixpkgs.config.allowUnfree = isEnabled;
  virtualisation.virtualbox.host.enableExtensionPack = isEnabled;
}
