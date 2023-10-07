{ pkgs, ... }:

let pamNamespaceRequired = pkgs.lib.mkDefault (
  pkgs.lib.mkAfter "session required pam_namespace.so\n"
);
in {
  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    polkit_gnome
    pinentry
    pass
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      enable = true;
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "default.target" ];
      wants = [ "default.target" ];
      after = [ "default.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  systemd.tmpfiles.rules = [
    "d /poly 000 root root -"
  ];

  security.pam.services = {
    login.text = pamNamespaceRequired;
    greetd.text = pamNamespaceRequired;
    sshd.text = pamNamespaceRequired;
  };

  environment.etc = {
    "security/namespace.conf".text = ''
      /tmp    /poly/tmp    tmpdir    root
      /media/steam-library/SteamLibrary/steamapps/compatdata    /poly/steam/compatdata    user    root
    '';
  };
}
