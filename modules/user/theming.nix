{ nixosConfig, config, lib, pkgs, ... }:
with lib;
with types;
let cfg = config.theming;
in {
  options = {
    theming.gui = {
      enable = mkOption {
        type = bool;
        default = nixosConfig.gui.enable;
      };

      style = {
        package = mkOption {
          type = package;
          default = pkgs.nordic;
        };

        name = mkOption {
          type = str;
          default = "Nordic";
        };
      };

      cursors = {
        package = mkOption {
          type = package;
          default = pkgs.quintom-cursor-theme;
        };

        name = mkOption {
          type = str;
          default = "Quintom_Ink";
        };

        size = mkOption {
          type = number;
          default = 24;
        };
      };

      icons = {
        package = mkOption {
          type = package;
          default = pkgs.zafiro-icons;
        };

        name = mkOption {
          type = str;
          default = "Zafiro-icons-Dark";
        };
      };

      wallpapers = {
        active = mkOption { type = path; };
        screensaver = mkOption { type = path; };
      };

      fonts = {
        packages = mkOption {
          type = listOf package;
          default = [ ];
        };

        defaults = {
          enable = mkOption {
            type = bool;
            default = nixosConfig.gui.enable;
          };

          packages = mkOption {
            type = listOf package;
            default = with pkgs; [
              (iosevka.override {
                set = "Ship";
                privateBuildPlan = {
                  family = "Iosevka Ship";
                  spacing = "normal";
                  serifs = "sans";
                  noCvSs = false;
                  buildTextureFeature = true;
                  exportGlyphNames = true;

                  variants.inherits = "ss04";
                  ligations.inherits = "dlig";
                };
              })
              (iosevka.override {
                set = "Ship";
                privateBuildPlan = {
                  family = "Iosevka Ship Term";
                  spacing = "term";
                  serifs = "sans";
                  noCvSs = false;
                  buildTextureFeature = true;
                  exportGlyphNames = true;

                  variants.inherits = "ss04";
                };
              })
              iosevka
              meslo-lgs-nf
              noto-fonts
            ];
          };

          serif = mkOption {
            type = listOf str;
            default = [ "Iosevka Ship" ];
          };
          sansSerif = mkOption {
            type = listOf str;
            default = [ "Iosevka Ship" ];
          };
          monospace = mkOption {
            type = listOf str;
            default = [ "Iosevka Ship Term" "MesloLGS NF" ];
          };
          emoji = mkOption {
            type = listOf str;
            default = [ "Noto Color Emoji" ];
          };
        };
      };
    };
  };

  config = {
    fonts.fontconfig = mkIf cfg.gui.fonts.defaults.enable {
      enable = true;
      defaultFonts = {
        serif = cfg.gui.fonts.defaults.serif;
        sansSerif = cfg.gui.fonts.defaults.sansSerif;
        monospace = cfg.gui.fonts.defaults.monospace;
        emoji = cfg.gui.fonts.defaults.emoji;
      };
    };

    xdg.dataFile."fonts" = mkIf cfg.gui.fonts.defaults.enable {
      source = config.lib.file.mkOutOfStoreSymlink
        "/run/current-system/sw/share/X11/fonts";
    };

    home.pointerCursor = mkIf cfg.gui.enable {
      package = cfg.gui.cursors.package;
      name = cfg.gui.cursors.name;
      size = cfg.gui.cursors.size;
      x11.enable = true;
      gtk.enable = true;
    };

    gtk = {
      enable = cfg.gui.enable;
      theme = {
        package = cfg.gui.style.package;
        name = cfg.gui.style.name;
      };
      iconTheme = {
        package = cfg.gui.icons.package;
        name = cfg.gui.icons.name;
      };

      font.name = "Regular";

      gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };

      gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };

      # FIXME use dconf
      # gtk4.extraConfig = {
      #   gtk-theme-name = "Nordic";
      # };
    };

    # FIXME see https://discourse.nixos.org/t/guide-to-installing-qt-theme/35523/2
    # qt = {
    #   enable = true;
    #   platformTheme.name = "qtct";
    #   style = {
    #     package = pkgs.nordic;
    #     name = "Nordic";
    #   };
    # };

    programs = mkIf cfg.gui.enable {
      swaylock.settings.image =
        builtins.toString cfg.gui.wallpapers.screensaver;
    };
    services = mkIf cfg.gui.enable {
      wpaperd.settings.default.path = cfg.gui.wallpapers.active;
    };
  };
}
