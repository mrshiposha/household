{ pkgs ? import <nixpkgs> {} }: pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
        vulkan-tools
    ];
}
