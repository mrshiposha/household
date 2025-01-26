household: {
	_module.args.household = household;

	imports = [
		./programs
		./theming.nix
		./unfree.nix

		./presets
	];
}
