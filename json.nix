{ pkgs, ... }: {
    environment.systemPackages = [
        pkgs.jq
        pkgs.jless
    ];
}
