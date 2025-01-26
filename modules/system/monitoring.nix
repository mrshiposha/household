{ lib, ... }: {
  services.smartd = {
    enable = lib.mkDefault true;
    # TODO emails
  };
}
