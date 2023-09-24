{ 
  rustPlatform,
  lib,
  fetchFromGitHub,
  pam,
  scdoc,
  installShellFiles
}:

rustPlatform.buildRustPackage rec {
  pname = "greetd";
  version = "0.8.0-multiseat";

  src = fetchFromGitHub {
    owner = "mrshiposha";
    repo = pname;
    rev = version;
    sha256 = "sha256-nKpv/qgyJA2RhlXq6h5xcHc3BwwOQFj3Mdrsex+10R8=";
  };

  cargoHash = "sha256-UNrzqn95lbr2OJZyHKUJkENWMX789TO7juj+sx6WWnQ=";

  nativeBuildInputs = [
    scdoc
    installShellFiles
  ];

  buildInputs = [
    pam
  ];

  postInstall = ''
    for f in man/*; do
      scdoc < "$f" > "$(sed 's/-\([0-9]\)\.scd$/.\1/' <<< "$f")"
      rm "$f"
    done
    installManPage man/*
  '';
}
