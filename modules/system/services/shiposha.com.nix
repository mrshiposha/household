{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.services."shiposha.com";
  zitadelPort = 49000;
  zitadelDbAdminUser = "zitadel_admin";
  zitadelHome = "/home/zitadel";
  zitadelSecrets = "${zitadelHome}/secrets";

  idDomain = "id.shiposha.com";
  vpnDomain = "vpn.shiposha.com";
  relayDomain = "relay.shiposha.com";
in
{
  options.services."shiposha.com" = {
    enable = mkEnableOption "shiposha.com service";
  };

  config = mkIf cfg.enable {
    programs.mtr.enable = true;
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "daniel@shiposha.com";
        webroot = "/var/lib/acme/acme-challenge";
      };
      certs."shiposha.com".extraDomainNames = [
        idDomain
        vpnDomain
      ];
    };
    services.nginx = {
      enable = true;
      virtualHosts = {
        "shiposha.com" = {
          forceSSL = true;
          enableACME = true;
          default = true;
          locations."/" = {
            return = "200 '<html><body>Temporary Dummy Content</body></html>'";
            extraConfig = ''
              default_type text/html;
            '';
          };
        };

        ${idDomain} = {
          forceSSL = true;
          useACMEHost = "shiposha.com";
          locations."/".extraConfig = ''
            grpc_pass grpc://localhost:${builtins.toString zitadelPort};
            grpc_set_header Host $host;
          '';
        };

        ${vpnDomain} = {
          forceSSL = true;
          useACMEHost = "shiposha.com";
        };
      };
    };

    services.db = {
      enable = true;

      users.${zitadelDbAdminUser} = {
        passwordFile = config.secrets.zitadel.secret.path;
      };

      postInitScript = pkgs.writeText "db-init-script" ''
        ALTER USER ${zitadelDbAdminUser} CREATEROLE CREATEDB;
      '';
    };

    users.users.zitadel = {
      isSystemUser = true;
      createHome = true;
      home = zitadelHome;
      group = "zitadel";
    };
    users.groups.zitadel = {};
    systemd.services.zitadel-setup =
    let
      secretPattern = "@ZITADEL_PASSWORD@";
      secretTemplate = (pkgs.formats.yaml {}).generate "secret-template.yaml" {
        Database.postgres = {
          User = {
            Username = "zitadel";
            Password = secretPattern;
            SSL.Mode = "disable";
          };

          Admin = {
            Username = zitadelDbAdminUser;
            Password = secretPattern;
            SSL.Mode = "disable";
          };
        };
      };
    in {
      wantedBy = [ "multi-user.target" ];
      before = [ "zitadel.service" ];
      serviceConfig = {
        Type = "oneshot";
        User = "zitadel";
      };
      path = with pkgs; [ replace-secret ];
      script = ''
        cp ${secretTemplate} ${zitadelSecrets}
        chmod 600 ${zitadelSecrets}
        replace-secret ${secretPattern} ${config.secrets.zitadel.secret.path} ${zitadelSecrets}
      '';
    };

    services.zitadel = {
      enable = true;
      tlsMode = "external";
      settings = {
        ExternalDomain = idDomain;
        ExternalPort = 443;
        ExternalSecure = true;
        Port = zitadelPort;
        TLS.Enabled = false;

        Database.postgres = {
          Host = "localhost";
          Port = config.services.db.port;
          Database = "zitadel";
        };
      };
      extraSettingsPaths = [zitadelSecrets];
      steps = let orgName = "Shiposha Family Services"; in {
        FirstInstance = {
          InstanceName = orgName;
          Org = {
            Name = orgName;
            Human = {
              UserName = "daniel@shiposha.com";
              Password = "3eIn!tial:Pass";
              FirstName = "Daniel";
              LastName = "Shiposha";
            };
          };
        };
      };
      masterKeyFile = config.secrets.zitadel.secret.path;
    };

    services.netbird.server =
    let
      cliendId = "301336611243753502";
    in {
      enable = true;
      domain = vpnDomain;
      enableNginx = true;

      management = {
        oidcConfigEndpoint = "https://${idDomain}/.well-known/openid-configuration";
        turnDomain = mkForce relayDomain;
        settings = {
          DataStoreEncryptionKey._secret = config.secrets.netbird-key.secret.path;
          TURNConfig = {
            Secret._secret = config.secrets.netbird-turn.secret.path;
            Turns = [
              (let
                turnPort = config.services.coturn.tls-listening-port;
              in {
                Proto = "udp";
                URI = "turn:${relayDomain}:${builtins.toString turnPort}";
                Username = "netbird";
                Password = { _secret = config.secrets.coturn.secret.path; };
              })
            ];
          };

          HttpConfig = {
            AuthIssuer = "https://${idDomain}";
            AuthAudience = cliendId;
            IdpSignKeyRefreshEnabled = true;
          };

          IdpManagerConfig = {
            ManagerType = "zitadel";
            ClientConfig = {
              Issuer = "https://${idDomain}";
              TokenEndpoint = "https://${idDomain}/oauth/v2/token";
              ClientID = "netbird";
              ClientSecret._secret = config.secrets.netbird-client.secret.path;
              GrantType = "client_credentials";
            };
            ExtraConfig = {
              ManagementEndpoint = "https://${idDomain}/management/v1";
            };
          };

          DeviceAuthorizationFlow = {
            Provider = "hosted";
            ProviderConfig = {
              ClientID = cliendId;
              Audience = cliendId;
              AuthorizationEndpoint = "https://${idDomain}/oauth/v2/device_authorization";
              TokenEndpoint = "https://${idDomain}/oauth/v2/token";
              Scope = "openid profile email offline_access api";
            };
          };

          PKCEAuthorizationFlow.ProviderConfig = {
            Audience = cliendId;
            ClientID = cliendId;
            AuthorizationEndpoint = "https://${idDomain}/oauth/v2/authorize";
            TokenEndpoint = "https://${idDomain}/oauth/v2/token";
            Scope = "openid profile email offline_access api";
            RedirectURLs = [ "http://localhost:53000" ];
          };
        };
      };

      dashboard.settings = {
        AUTH_AUDIENCE = cliendId;
        AUTH_CLIENT_ID = cliendId;
        USE_AUTH0 = false;
        AUTH_SUPPORTED_SCOPES = "openid profile email offline_access api";
        NETBIRD_TOKEN_SOURCE = "idToken";
        AUTH_AUTHORITY = "https://${idDomain}";
        AUTH_REDIRECT_URI = "/peers";
        AUTH_SILENT_REDIRECT_URI = "/add-peers";
      };

      coturn = {
        enable = true;
        useAcmeCertificates = true;
        passwordFile = config.secrets.coturn.secret.path;
        domain = relayDomain;
      };
    };
  };
}
