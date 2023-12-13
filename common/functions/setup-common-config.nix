{ lib, config-dir }:
let cfg-files = lib.filesystem.listFilesRecursive config-dir; 
    cfg-sets = lib.listToAttrs (
     map
      (cfg-file:
        let
          config-name = baseNameOf (dirOf cfg-file);
          filename = baseNameOf cfg-file;
        in {
          # TODO replace all '/'
          name = (builtins.unsafeDiscardStringContext "${config-name}-${filename}-config");
          value = {
            target = (builtins.unsafeDiscardStringContext ".config/${config-name}/${filename}");
            source = cfg-file;
          };
        }
      )
      cfg-files
    );
in {
  home.file = cfg-sets;
}

