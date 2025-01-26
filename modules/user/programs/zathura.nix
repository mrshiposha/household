{ config, lib, ... }:
with lib;
with lib.types;
{
	options.zathura = {
		enable = mkEnableOption "zathura";
		defaultPdfApp = mkOption {
			type = bool;
			default = true;
		};
	};

	config = mkIf config.zathura.enable {
		programs.zathura = {
			enable = true;
			options = {
				selection-clipboard = "clipboard";

				notification-error-bg = "#2E3440";
				notification-error-fg = "#BF616A";
				notification-warning-bg = "#2E3440";
				notification-warning-fg = "#D08770";
				notification-bg = "#2E3440";
				notification-fg = "#D8DEE9";

				completion-bg = "#2E3440";
				completion-fg = "#D8DEE9";
				completion-group-bg = "#3B4252";
				completion-group-fg = "#D8DEE9";
				completion-highlight-bg = "#88C0D0";
				completion-highlight-fg = "#3B4252";

				index-bg = "#2E3440";
				index-fg = "#8FBCBB";
				index-active-bg = "#8FBCBB";
				index-active-fg = "#2E3440";

				inputbar-bg = "#2E3440";
				inputbar-fg = "#E5E9F0";

				statusbar-bg = "#2E3440";
				statusbar-fg = "#E5E9F0";

				highlight-color = "rgba(143, 188, 187, 0.5)";
				highlight-active-color = "rgba(136, 192, 208, 0.5)";

				default-bg = "rgba(46, 52, 64, 0.8)";
				default-fg = "#D8DEE9";
				render-loading = "true";
				render-loading-bg = "#2E3440";
				render-loading-fg = "#434C5E";

				recolor-lightcolor = "rgba(0, 0, 0, 0)";
				recolor-darkcolor = "#ECEFF4";
				recolor = "true";
			};
		};

		xdg.mimeApps.defaultApplications."application/pdf" = mkIf
			config.zathura.defaultPdfApp
			[ "org.pwmt.zathura.desktop" ];
	};
}
