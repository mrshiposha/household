household: {
  _module.args.household = household;

  imports = [
    ./programs
    ./services
    ./theming.nix
    ./unfree.nix

    ./presets
  ];
}
