{ pkgs, ... }: with pkgs; {
  home.packages = [
    blender-hip
    blockbench-electron
  ];
}
