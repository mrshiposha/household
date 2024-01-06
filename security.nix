{ pkgs, ... }: {
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
}
