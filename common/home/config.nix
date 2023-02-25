common-home: { ... }: {
  home.file.config = {
    target = ".config";
    source = "${common-home}/.config";
    recursive = true;
  };
}
