{ config, pkgs, ... }: {
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
}
