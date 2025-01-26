{ config, lib, pkgs, ... }:
with lib;
{
	options.yazi.enable = mkEnableOption "yazi";

	config = mkIf config.yazi.enable {
		home.packages = with pkgs; [ exiftool ];
		programs.yazi = {
			enable = true;
			enableZshIntegration = true;
			settings = {
				show_hidden = false;
			};

			keymap = {
				manager.prepend_keymap = [
					{
						on = [ "<Enter>" ];
						run  = "plugin --sync smart-enter";
						desc = "Enter the child directory, or open the file";
					}
				];
			};
		};

		xdg.configFile.yazi-smart-enter = {
			target = "yazi/plugins/smart-enter.yazi/init.lua";
			text = ''
				return {
					entry = function()
						local h = cx.active.current.hovered
						ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
						end,
				}
			'';
		};
	};
}
