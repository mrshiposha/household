# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.interfaces.enp3s0.ipv4.addresses = [ { address = "192.168.0.xx"; prefixLength = 24; } ];
  # networking.interfaces.enp3s0.useDHCP = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    useNetworkd = true;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    nftables.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Belgrade";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mrshiposha = {
    isNormalUser = true;
    uid = 1000;
    description = "Daniel Shiposha";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
  };
  users.users.navigator = {
    description = "fleet navigator";
    isNormalUser = true;
    uid = 1010;
    group = "wheel";
    shell = pkgs.zsh;
    hashedPassword = "!";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINtzZVQaPQiYzzuV8ZKdQ7mCXV1uug652EKJRdXpj+ZE navigator@shiposha.com"
    ];
  };
  home-manager.users = {
    mrshiposha = {
      home.stateVersion = "25.05";
      programs.zsh.enable = true;
    };
    navigator = {
      home.stateVersion = "25.05";
      programs.zsh.enable = true;
    };
  };

  security.sudo.extraConfig = ''
    navigator ALL=(ALL) NOPASSWD:ALL
  '';
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
  };
  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.settings.trusted-users = [ "@wheel" ];
  nix.settings.trusted-public-keys =
    [ "satellite-1:AAMTT4U2aR46/PhIa0HxcNnqN9IfTI6uCXICcxA1yQY=" ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
