{config, pkgs, ...}:
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  # systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
  # dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
  dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = ''
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Nordic'
        gsettings set $gnome_schema cursor-theme 'Quintom_Ink'
        gsettings set $gnome_schema icon-theme 'Zafiro-icons-Dark'
      '';
  };
in {
  imports = [ ./security.nix ./json.nix ];

  environment.systemPackages = with pkgs; [
    sway
    dbus
    dbus-sway-environment
    configure-gtk
    wayland
    xdg-utils # for opening default programs when clicking links
    glib # gsettings

    # for rendering SVG icons
    librsvg

    # gtk theme
    nordic
    zafiro-icons
    quintom-cursor-theme

    swaylock
    swayidle
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout

    mako # notification system developed by swaywm maintainer
    libnotify

    # Screenshots
    grim
    slurp

    xsettingsd
  ];

  environment.sessionVariables = {
    XDG_DATA_DIRS = [ datadir ];

    # NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";

    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_DESKTOP = "sway";

    XCURSOR_THEME = "Quintom_Ink";

    GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-*/*/loaders.cache)";
  } // (if config.virtualisation.virtualbox.guest.enable then {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    LIBGL_ALWAYS_SOFTWARE = "1";
  } else {});

  programs.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
    };
    extraPackages = [];
  };

  programs.wshowkeys.enable = true;

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
