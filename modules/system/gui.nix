{ config, lib, pkgs, flakeInputs, ... }:
with lib;
with types;
let cfg = config.gui;
in {
  options.gui = {
    enable = mkEnableOption "GUI";

    games = {
      enable = mkEnableOption "games";
      mountSharedLibraryFor = mkOption {
        type = listOf (submodule {
          options = {
            ownerName = mkOption { type = str; };
            ownerId = mkOption { type = int; };
            groupId = mkOption { type = int; };
          };
        });
        default = [ ];
      };
    };

    greeter.seat0.theme = {
      wallpaper = mkOption { type = path; };

      style = {
        package = mkOption { type = package; };

        name = mkOption { type = str; };
      };

      cursors = {
        package = mkOption { type = package; };

        name = mkOption { type = str; };

        size = mkOption { type = number; };
      };

      icons = {
        package = mkOption { type = package; };

        name = mkOption { type = str; };
      };

      font = {
        name = mkOption { type = str; };

        size = mkOption {
          type = number;
          default = 16;
        };
      };
    };
  };

  config = let greeterTheme = cfg.greeter.seat0.theme;
  in mkMerge [
    (mkIf cfg.enable {
      audio.enable = mkDefault true;

      programs = {
        hyprland.enable = true;
        wshowkeys.enable = true;
      };

      xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

      environment.systemPackages = with pkgs; [
        libsForQt5.qt5.qtwayland
        qt6.qtwayland
      ];

      programs.nix-ld.libraries = pkgs.steam-run.args.multiPkgs pkgs;

      programs.regreet = {
        enable = true;
        package = flakeInputs.multiseat.packages."x86_64-linux".regreet;
        theme = greeterTheme.style;
        iconTheme = greeterTheme.icons;
        cursorTheme = {
          name = greeterTheme.cursors.name;
          package = greeterTheme.cursors.package;
        };
        font = {
          name = greeterTheme.font.name;
          size = greeterTheme.font.size;
        };

        settings = {
          background = {
            path = greeterTheme.wallpaper;
            fit = "Contain";
          };
        };
      };
      services.greetd.package =
        flakeInputs.multiseat.packages."x86_64-linux".greetd;

      security.pam.services.swaylock = { };
      security.rtkit.enable = true;

      systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
          description = "polkit-gnome-authentication-agent-1";
          wantedBy = [ "graphical-session.target" ];
          wants = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
          serviceConfig = {
            Type = "simple";
            ExecStart =
              "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };
      };
    })

    ({
      programs = {
        thunar = {
          enable = true;
          plugins = with pkgs; [
            xfce.thunar-archive-plugin
            xfce.thunar-volman
          ];
        };
        xfconf.enable = true;
        file-roller.enable = true;
      };
      services = {
        gvfs.enable = true;
        tumbler.enable = true;
      };
      environment.systemPackages = with pkgs; [
        ffmpegthumbnailer
        webp-pixbuf-loader
        poppler
        freetype
        libgsf
        gnome-epub-thumbnailer
        f3d
      ];
    })

    (mkIf config.laptop.enable {
      services.logind.lidSwitch = "suspend-then-hibernate";
      systemd.sleep.extraConfig = "	HibernateDelaySec = 600\n";
    })

    (mkIf cfg.games.enable {
      programs = {
        steam = {
          enable = true;
          package = pkgs.steam.override {
            # Workaround for DRI_PRIME issue
            # See https://github.com/ValveSoftware/steam-for-linux/issues/9383
            # See https://github.com/ValveSoftware/steam-for-linux/issues/11113
            extraArgs = "-no-cef-sandbox -cef-disable-gpu";

            extraLibraries = p:
              with p; [
                # For Substance 3D Painter 2025
                brotli
                xorg.libSM
                xorg.libICE
                xorg.libxkbfile
                xorg.libxcb
                xorg.xcbutilwm # libxcb-icccm.so.4
                xcb-util-cursor
                (libtiff.overrideAttrs (final: prev: rec {
                  version = "4.4.0";
                  src = fetchFromGitLab {
                    owner = "libtiff";
                    repo = "libtiff";
                    rev = "v${version}";
                    hash =
                      "sha256-VfC2HeQU49v8QuxjvABtRBEud898WDCMPC11Jo/GuI8=";
                  };
                  patches = [ ];
                  cmakeFlags = [ ];

                  postFixup = ''
                    mkdir -p $dev_private/include
                    mv -t $dev_private/include \
                      libtiff/tif_config.h \
                      ../libtiff/tif_dir.h \
                      ../libtiff/tiffiop.h
                  '';

                }))
              ];
          };
          extraPackages = with pkgs; [
            mangohud
            # TODO obs-studio-plugins.obs-vkcapture

            # TODO some of this stuff should go to extraLibraries instead
            udev
            alsa-lib
            mono
            dotnet-sdk
            stdenv
            clang_18
            icu
            openssl
            zlib
            SDL2
            SDL2.dev
            SDL2
            SDL2_image
            SDL2_ttf
            SDL2_mixer
            vulkan-loader
            vulkan-tools
            vulkan-validation-layers
            glib
            libxkbcommon
            nss
            nspr
            atk
            mesa
            dbus
            pango
            cairo
            libpulseaudio
            libGL
            expat
            libdrm
            wayland
          ];
        };
        gamemode.enable = true;
      };

      unfree.list = with pkgs; [ steam steam-unwrapped steam-run ];

      shared.directories = builtins.map (options: {
        source = /shared/steam/library;
        createSource = true;
        mount = {
          point = /home/${options.ownerName}/.local/share/Steam/steamapps;
          ownerId = options.ownerId;
          groupId = options.groupId;
        };
      }) cfg.games.mountSharedLibraryFor;
      systemd.tmpfiles.rules = lists.flatten (builtins.map (options: [
        "d /home/${options.ownerName}/.local/share/Steam 0755 ${options.ownerName} users - -"
        "d /home/${options.ownerName}/.local/share/Steam/steamapps 0755 ${options.ownerName} users - -"
      ]) cfg.games.mountSharedLibraryFor) ++ [
        "L+ /shared/steam/library/common/Steam.dll - - - - ../../legacycompat/Steam.dll"
      ];
      security.poly = {
        instances = [{
          mount = "/shared/steam/library/compatdata";
          owner = "root";
          group = "root";
          source = "/shared/steam/poly/compatdata";
          type = "user";
        }];
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      environment.systemPackages = with pkgs;
        [
          (lutris.override {
            extraPkgs = pkgs:
              with pkgs; [
                wineWowPackages.stable
                wine
                (wine.override { wineBuild = "wine64"; })
                wine64
                wineWowPackages.staging
                winetricks
                wineWowPackages.waylandFull
              ];
          })
        ];
    })
  ];
}
