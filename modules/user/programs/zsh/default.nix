{ config, pkgs, lib, ... }:
with lib;
{
	options.zsh.enable = mkEnableOption "zsh";

	config = mkIf config.zsh.enable {
		programs.zsh = {
			enable = true;
			plugins = [
				{
					file = "powerlevel10k.zsh-theme";
					name = "powerlevel10k";
					src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
				}
			];

			initExtra = ''
				function noop() { return true }
				zle -N noop

				# Ctrl + Left
				bindkey "^[[1;5D" backward-word

				# Ctrl + Right
				bindkey "^[[1;5C" forward-word

				# Ctrl + BS
				bindkey "^[[127;5u" backward-kill-word

				# Ignore Shift + BS
				bindkey "^[[127;2u" noop

				# Ignore Alt + BS
				bindkey "^[\x7f" noop

				# Ignore Shift + Left Arrow
				bindkey "^[[1;2D" noop

				# Ignore Shift + Right Arrow
				bindkey "^[[1;2C" noop

				# Ignore Shift + Up Arrow
				bindkey "^[[1;2A" noop

				# Ignore Shift + Down Arrow
				bindkey "^[[1;2B" noop

				# Ignore Alt + Left Arrow
				bindkey "^[\[1;3D" noop

				# Ignore Alt + Right Arrow
				bindkey "^[\[1;3C" noop

				# Ignore Alt + Up Arrow
				bindkey "^[\[1;3A" noop

				# Ignore Alt + Down Arrow
				bindkey "^[\[1;3B" noop

				# Ignore Ctrl + Up Arrow
				bindkey "^[\[1;5A" noop

				# Ignore Ctrl + Down Arrow
				bindkey "^[\[1;5B" noop

				if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
					source ${./p10k/full.zsh}
				else
					source ${./p10k/minimal.zsh}
			fi
				'';
		};
	};

}
