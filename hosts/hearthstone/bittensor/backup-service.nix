{ pkgs, ... }: {
  systemd.user.services.bittensor-backup = {
    enable = true;
    unitConfig.ConditionUser = "mrshiposha";
    serviceConfig.Type = "oneshot";

    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [ bash openssh ];
    script = "bash " + ./backup-keys.sh;
  };

  systemd.user.timers.bittensor-backup = {
    wantedBy = [ "timers.target" ];
    partOf = [ "bittensor-backup.service" ];

    timerConfig = {
      OnCalendar = "10:00:00";
      Unit = "bittensor-backup.service";
    };
  };
}
