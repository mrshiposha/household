{ config, lib, ... }:
with lib;
{
	options.wezterm.enable = mkEnableOption "wezterm";

	config = mkIf config.wezterm.enable {
		programs.wezterm = {
			enable = true;
			enableBashIntegration = true;
			enableZshIntegration = true;
			extraConfig = ''
				local wezterm = require "wezterm"

				return {
					enable_wayland = false, -- https://github.com/wez/wezterm/issues/4483 + https://github.com/wez/wezterm/issues/5990

					color_scheme = "nord",
					window_background_opacity = 0.7,
					use_fancy_tab_bar = false,
					hide_tab_bar_if_only_one_tab = true,
					window_close_confirmation = "NeverPrompt",

					font = wezterm.font "monospace",
					front_end = "WebGpu",
					webgpu_power_preference = 'HighPerformance',

					colors = {
						tab_bar = {
							background = "#2e3440",

							active_tab = {
								bg_color = "#81a1c1",
								fg_color = "#e5e9f0",
							},

							inactive_tab = {
								bg_color = "#4c566a",
								fg_color = "#d8dee9",
							},

							inactive_tab_hover = {
								bg_color = "#5e81ac",
								fg_color = "#d8dee9",
								italic = true,
							},

							new_tab = {
								bg_color = "#3b4252",
								fg_color = "#d8dee9",
							},

							new_tab_hover = {
								bg_color = "#5e81ac",
								fg_color = "#d8dee9",

								italic = true,
							},
						},
					},
				}
			'';
		};
	};
}
