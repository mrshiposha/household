{ config, lib, ... }:
with lib;

let
	cfg = config.audio;
in
{
	options.audio = {
		enable = mkEnableOption "audio";
		bluetooth.enable = mkEnableOption "bluetooth";
	};

	config = mkMerge [
		(mkIf cfg.enable {
			services.pipewire = {
				enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
				pulse.enable = true;
			};
		})

		(mkIf cfg.bluetooth.enable {
			hardware.bluetooth = {
				enable = true;
				powerOnBoot = false;
			};

			services.blueman.enable = true;

			environment.etc = {
				"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
					bluez_monitor.properties = {
						["bluez5.enable-sbc-xq"] = true,
						["bluez5.enable-msbc"] = true,
						["bluez5.enable-hw-volume"] = true,
						["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
					}
				'';
			};
		})
	];

}
