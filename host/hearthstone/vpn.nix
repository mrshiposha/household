let 
  root = ./../..;
in (import "${root}/vpn.nix" {
    externalIface = "eno1";
})
