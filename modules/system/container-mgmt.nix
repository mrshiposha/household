{ config, pkgs, lib, ... }:
with lib;

let
	cfg = config.container-mgmt;
in
{
	options.container-mgmt.enable = mkEnableOption "containers";

	config = mkIf cfg.enable {
		virtualisation = {
			podman = {
				enable = true;

				# Create a `docker` alias for podman, to use it as a drop-in replacement
				dockerCompat = true;

				# Required for containers under podman-compose to be able to talk to each other.
				defaultNetwork.settings.dns_enabled = true;
			};
		};

		environment.systemPackages = [ pkgs.docker-compose ];
	};


}
