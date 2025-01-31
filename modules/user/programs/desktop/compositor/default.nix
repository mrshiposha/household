{ nixosConfig, config, pkgs, lib, ... }:
with lib;
with types;
let
	swaylock = rec {
		pkg = pkgs.swaylock-effects;
		bin = "${pkg}/bin/swaylock";
	};
	screenlock-config = "${config.home.homeDirectory}/${
		config.xdg.configFile."swaylock/config".target
	}";
	screen = {
		lock = "${swaylock.bin} -f -C ${screenlock-config}";
		off = "hyprctl dispatch dpms off";
		on = "hyprctl dispatch dpms on";
	};
	hibernate = "${pkgs.systemd}/bin/systemctl hibernate";
	autoLock = "${pkgs.swayidle}/bin/swayidle -w lock '${screen.lock}' before-sleep '${screen.lock}; ${screen.off}' after-resume '${screen.on}' timeout 600 '${screen.lock}' timeout 900 '${hibernate}'";
in
{
	options.compositor = {
		enable = mkEnableOption "desktop (hyprland compositor and friends)";
		extraSettings = mkOption {
			type = attrs;
			default = {};
		};
	};

	config = mkIf config.compositor.enable {
		wayland.windowManager.hyprland = {
			enable = true;
			systemd.enable = true;
			settings = {
				monitor=",preferred,auto,1";

				input = {
					kb_layout = "us,ru";
					kb_options = "grp:win_space_toggle";

					touchpad = {
						natural_scroll = true;
						scroll_factor = 0.4;
						tap-to-click = false;
					};

					sensitivity = 0.5;
				};

				misc.force_default_wallpaper = false;

				general = {
					gaps_in = 2;
					gaps_out = 5;
					border_size = 2;
					"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
					"col.inactive_border" = "rgba(595959aa)";

					layout = "dwindle";
					allow_tearing = false;
				};

				dwindle = {
					force_split = 2;
				};

				decoration = {
					rounding = 5;

					blur = {
						enabled = true;
						size = 5;
						passes = 1;
						new_optimizations = true;
					};
				};

				cursor.inactive_timeout = 3;
				debug.disable_logs = true;

				animations = {
					enabled = true;

					bezier = "openBezier, 0.05, 0.9, 0.1, 1.05";
					animation = let
						workspaces = if nixosConfig.laptop.enable
							then "workspaces, 1, 6, default"
							else "workspaces, 0";
					in [
						"windows, 1, 7, openBezier"
						"windowsOut, 1, 7, default, popin 80%"
						"border, 1, 10, default"
						"borderangle, 1, 8, default"
						"fade, 1, 7, default"
						workspaces
					];
				};

				xwayland = {
					force_zero_scaling = true;
				};

				workspace =
				let
					desktopRules = [
						"name:Down,persistent:true, monitor:DP-1, default:true"
						"name:Up,persistent:true, monitor:DP-1"
						"name:Left,persistent:true, monitor:DP-1"
						"name:Right,persistent:true, monitor:DP-1"
					];
					laptopRules = [
						"1,persistent:true, monitor:eDP-1, default:true"
						"2,persistent:true, monitor:eDP-1"
						"3,persistent:true, monitor:eDP-1"
						"4,persistent:true, monitor:eDP-1"

						"5,persistent:true, monitor:HDMI-A-1, default:true"
						"6,persistent:true, monitor:HDMI-A-1"
						"7,persistent:true, monitor:HDMI-A-1"
						"8,persistent:true, monitor:HDMI-A-1"
					];
				in if nixosConfig.laptop.enable
					then laptopRules else desktopRules;

				"$mainMod" = "Super";
				"$terminal" = "wezterm";
				"$reloadWaybar" = "pkill waybar ; waybar";

				bind =
				let
					desktopRules = [
						"$mainMod, Up, workspace, name:Up"
						"$mainMod, Down, workspace, name:Down"
						"$mainMod, Left, workspace, name:Left"
						"$mainMod, Right, workspace, name:Right"

						"$mainMod+Shift, Up, movetoworkspacesilent, name:Up"
						"$mainMod+Shift, Down, movetoworkspacesilent, name:Down"
						"$mainMod+Shift, Left, movetoworkspacesilent, name:Left"
						"$mainMod+Shift, Right, movetoworkspacesilent, name:Right"
					];
					laptopRules = [
						"$mainMod, 1, workspace, 1"
						"$mainMod, 2, workspace, 2"
						"$mainMod, 3, workspace, 3"
						"$mainMod, 4, workspace, 4"

						"$mainMod, 5, workspace, 5"
						"$mainMod, 6, workspace, 6"
						"$mainMod, 7, workspace, 7"
						"$mainMod, 8, workspace, 8"

						"$mainMod+Shift, 1, movetoworkspacesilent, 1"
						"$mainMod+Shift, 2, movetoworkspacesilent, 2"
						"$mainMod+Shift, 3, movetoworkspacesilent, 3"
						"$mainMod+Shift, 4, movetoworkspacesilent, 4"

						"$mainMod+Shift, 5, movetoworkspacesilent, 5"
						"$mainMod+Shift, 6, movetoworkspacesilent, 6"
						"$mainMod+Shift, 7, movetoworkspacesilent, 7"
						"$mainMod+Shift, 8, movetoworkspacesilent, 8"

						"$mainMod, Right, workspace, e+1"
						"$mainMod, Left, workspace, e-1"

						"$mainMod+Shift, Right, movetoworkspace, e+1"
						"$mainMod+Shift, Left, movetoworkspace, e-1"
					];
					printscreen = "grim -g \"$(slurp -d)\" - | wl-copy --type image/png";
				in [
					"$mainMod+Shift, Return, exec, $terminal"
					"Super_L, P, exec, $terminal"

					"$mainMod, Return, exec, rofi -show drun -show-icons"
					"$mainMod, Q, killactive,"
					"$mainMod+Shift, E, exit,"
					"$mainMod, L, exec, ${screen.lock}"
					"$mainMod+Shift, C, exec, $reloadWaybar"
					"$mainMod+Shift, F, togglefloating,"
					"$mainMod, F, fullscreen,"

					", XF86AudioRaiseVolume, exec, pamixer --increase 5"
					", XF86AudioLowerVolume, exec, pamixer --decrease 5"
					", XF86AudioMute, exec, pamixer --toggle-mute"
					", XF86AudioMicMute, exec, pamixer --source alsa_input.pci-0000_00_1f.3.analog-stereo --toggle-mute"

					", XF86MonBrightnessUp, exec, brightnessctl -q set 5%+"
					", XF86MonBrightnessDown, exec, brightnessctl -q set 5%-"

					", XF86Favorites, exec, rofi -show power-menu"

					", XF86Calculator, exec, rofi -show calc"

					"Super_L+Shift_L, S, exec, ${printscreen}"
					", XF86Tools, exec, ${printscreen}"
					", Print, exec, ${printscreen}"

					"$mainMod+Alt, Right, movefocus, r"
					"$mainMod+Alt, Left, movefocus, l"
					"$mainMod+Alt, Up, movefocus, u"
					"$mainMod+Alt, Down, movefocus, d"

					"$mainMod+Ctrl, Right, movewindow, r"
					"$mainMod+Ctrl, Left, movewindow, l"
					"$mainMod+Ctrl, Up, movewindow, u"
					"$mainMod+Ctrl, Down, movewindow, d"

				] ++ (
					if nixosConfig.laptop.enable
						then laptopRules
						else desktopRules
				);

				gestures = {
					workspace_swipe = true;
					workspace_swipe_distance = 150;
				};

				bindm = [
					"$mainMod, mouse:272, movewindow"
					"$mainMod, mouse:273, resizewindow"
				];

				windowrulev2 =
				let
					terminal_class = "(org\\.wezfurlong\\.wezterm)";
					vscode_class = "VSCodium|Codium";
				in
					[
					  "float,class:${terminal_class}"
						"size 1400 800,class:${terminal_class}"
						"center,class:${terminal_class}"

						"opacity 0.7, class:${vscode_class}"

						"float,class:com.interversehq.qView"

						"float,class:PureRef"
						"size 512 512,class:PureRef"
						"move 100%-w-32 100%-w-64,class:PureRef"

						"float,class:io.gitlab.adhami3310.Converter"
						"float,class:com.belmoussaoui.Decoder"
						"size 620 710,class:com.belmoussaoui.Decoder"

						"float,class:usbimager"
						"size 480 190,class:usbimager"

						"float,class:steam"

						"float,class:thunar,title:File Operation Progress"
					];

				exec-once = [ "wpaperd" ] ++ (
					if nixosConfig.laptop.enable
					then [
						(builtins.toString ./init-laptop-workspaces.sh)
						autoLock
					]
					else [
						(builtins.toString ./init-desktop-workspaces.sh)
					]
				);
			} // config.compositor.extraSettings;
		};

		programs.wpaperd.enable = true;
		programs.swaylock = {
			enable = true;
			package = swaylock.pkg;
			settings = {
				indicator = true;
				indicator-radius = 100;
				show-keyboard-layout = true;

				clock = true;
				timestr = "%R";
				datestr = "%Y-%m-%d";

				line-uses-ring = true;

				bs-hl-color = "b48eadff";
				caps-lock-bs-hl-color = "d08770ff";
				caps-lock-key-hl-color = "ebcb8bff";
				inside-color = "2e3440ff";
				inside-clear-color = "81a1c1ff";
				inside-ver-color = "5e81acff";
				inside-wrong-color = "bf616aff";
				key-hl-color = "a3be8cff";
				layout-bg-color = "2e3440ff";

				ring-color = "4c566aff";
				ring-clear-color = "88c0d0ff";
				ring-ver-color = "81a1c1ff";
				ring-wrong-color = "d08770ff";
				separator-color = "3b4252ff";
				text-color = "eceff4ff";
				text-clear-color = "3b4252ff";

				text-ver-color = "3b4252ff";
				text-wrong-color = "3b4252ff";
			};
		};

		home.packages = with pkgs; [
			grim
			slurp
			wl-clipboard
		];
	};
}
