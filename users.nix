{ lib, ... }: {
  imports = lib.filesystem.listFilesRecursive ./users;
}
