filename: common-home: path: {
  home.file.${filename} = {
    target = path;
    source = "${common-home}/${path}";
  };
}
