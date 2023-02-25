{ ... }: {
  home.file.config = {
    target = ".config";
    source = ./.config;
    recursive = true;
  };
}
