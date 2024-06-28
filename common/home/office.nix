{ pkgs, ... }: with pkgs; {
  home.packages = [
    logseq
    thunderbird
    skypeforlinux
  ];

  programs.obs-studio = {
    enable = true;
    package = obs-studio;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-vaapi
    ];
  };

}
