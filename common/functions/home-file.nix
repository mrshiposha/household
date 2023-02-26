{
  name,
  source-root,
  path
}: {
  home.file.${name} = {
    target = path;
    source = "${source-root}/${path}";
  };
}
