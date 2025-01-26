{ nixosConfig, config, pkgs, lib, ... }:
with lib;
let
	cfg = config.preset.regularUser;
in
{
	options.preset.regularUser.enable = mkEnableOption "regular user preset";

	config = mkIf cfg.enable {
		zsh.enable = mkDefault true;

		crypto.enable = mkDefault true;

		desktop.enable = mkDefault nixosConfig.gui.enable;
		wezterm.enable = mkDefault nixosConfig.gui.enable;
		firefox.enable = mkDefault nixosConfig.gui.enable;
		stats.enable = mkDefault nixosConfig.gui.enable;
		zathura.enable = mkDefault nixosConfig.gui.enable;
		connections = {
			telegram.enable = mkDefault nixosConfig.gui.enable;
			discord.enable = mkDefault nixosConfig.gui.enable;
		};

		home.packages = with pkgs; mkMerge [
			(mkIf nixosConfig.gui.enable [
				xdg-utils
				qview
				switcheroo
				gnome-decoder
			])
			[ trash-cli ]
		];

		xdg =
		let
			filemanagerDesktop = [ "thunar.desktop" ];
			archiverDesktop = [ "org.gnome.FileRoller.desktop" ];
			imageViewerDesktop = [ "qview.desktop" ];
		in mkIf nixosConfig.gui.enable {
			mimeApps = {
				enable = true;
				defaultApplications = mkIf nixosConfig.gui.enable {
					"inode/directory" = mkDefault	filemanagerDesktop;

					"application/x-7z-compressed" = mkDefault archiverDesktop;
					"application/x-ace-compressed" = mkDefault archiverDesktop;
					"application/x-alz-compressed" = mkDefault archiverDesktop;
					"application/x-archive" = mkDefault archiverDesktop;
					"application/x-arj" = mkDefault archiverDesktop;
					"application/vnd.ms-cab-compressed" = mkDefault archiverDesktop;
					"application/x-cpio" = mkDefault archiverDesktop;
					"application/x-iso9660-image" = mkDefault archiverDesktop;
					"application/java-archive" = mkDefault archiverDesktop;
					"application/x-lzh" = mkDefault archiverDesktop;
					"application/x-rar-compressed" = mkDefault archiverDesktop;
					"application/x-stuffit" = mkDefault archiverDesktop;
					"application/x-gtar" = mkDefault archiverDesktop;
					"application/zip" = mkDefault archiverDesktop;
					"application/x-zoo" = mkDefault archiverDesktop;
					"application/gzip" = mkDefault archiverDesktop;
					"application/x-bzip2" = mkDefault archiverDesktop;
					"application/x-lzip" = mkDefault archiverDesktop;
					"application/x-lzop" = mkDefault archiverDesktop;
					"application/x-xz" = mkDefault archiverDesktop;

					"image/jpg" = mkDefault imageViewerDesktop;
					"image/bmp" = mkDefault imageViewerDesktop;
					"image/gif" = mkDefault imageViewerDesktop;
					"image/x-jp2" = mkDefault imageViewerDesktop;
					"image/jpeg" = mkDefault imageViewerDesktop;
					"image/jpe" = mkDefault imageViewerDesktop;
					"image/svg+xml" = mkDefault imageViewerDesktop;
					"image/tif" = mkDefault imageViewerDesktop;
					"image/tiff" = mkDefault imageViewerDesktop;
					"image/webp" = mkDefault imageViewerDesktop;
				};
			};
		};

		home.stateVersion = nixosConfig.system.stateVersion;
	};
}
