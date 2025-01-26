{
  users.users.nix-remote = {
    description = "The remote user of Nix";
    isSystemUser = true;
    group = "nix-remote";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhQd5uSir7W34O+FdwWdVBrOZtI7nokHJTfEB7ltN1p satellite"
    ];
    useDefaultShell = true;
  };
  users.groups.nix-remote = {};
}
