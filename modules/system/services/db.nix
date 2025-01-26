{ config, lib, pkgs, ... }:
with lib;
with lib.types;

let
  cfg = config.services.db;
in
{
  options.services.db = {
    enable = mkEnableOption "database service";
    port = mkOption {
      type = number;
      default = 5432;
    };
    users = mkOption {
      type = attrsOf (submodule ({name, ...}: {
        options = {
          passwordFile = mkOption {
            type = nullOr path;
            default = null;
          };
        };
      }));
    };
    databases = mkOption {
      type = listOf str;
      default = [];
    };
    postInitScript = mkOption {
      type = nullOr path;
      default = null;
    };
  };

  config = mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      settings.port = cfg.port;
      ensureUsers = attrsets.mapAttrsToList
        (name: options: {
          inherit name;
          ensureDBOwnership = true;
        })
        cfg.users;
      ensureDatabases = cfg.databases
        ++ builtins.attrNames cfg.users;
      authentication = ''
        host    all    all    localhost    scram-sha-256
      '';
    };

    systemd.services.postgresql-setup = let
      psql = "sudo -u postgres psql";
      setupPasswords = strings.concatLines (
        attrsets.mapAttrsToList (
          user: options: let password = if options.passwordFile == null
            then "NULL"
            else "'$(cat ${options.passwordFile})'";
          in ''${psql} -c "ALTER USER \"${user}\" PASSWORD ${password};"''
        ) cfg.users
      );
      postInit = if cfg.postInitScript == null
        then ""
        else "${psql} --file ${cfg.postInitScript}";
    in {
      wantedBy = [ "multi-user.target" ];
      after = [ "postgresql.service" ];
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      path = with pkgs; [ postgresql_16 sudo ];
      script = ''
        ${setupPasswords}
        ${postInit}
      '';
    };
  };
}
