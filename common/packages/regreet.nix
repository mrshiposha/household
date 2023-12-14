{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, wrapGAppsHook
, glib
, gtk4
, pango
, librsvg
}:

rustPlatform.buildRustPackage rec {
  pname = "regreet";
  version = "0.1.1-multiseat";

  src = fetchFromGitHub {
    owner = "mrshiposha";
    repo = "ReGreet";
    rev = version;
    hash = "sha256-UHJmjz6khAwZY6DXIowJW0eRPw98A58iGLOQ7jIrvWo=";
  };

  cargoHash = "sha256-AlM9+19FxQ71VLxgm4OaWx0us30wdKJOmGPa+BAXbko=";

  buildFeatures = [ "gtk4_8" ];

  nativeBuildInputs = [ pkg-config wrapGAppsHook ];
  buildInputs = [ glib gtk4 pango librsvg ];
}
