{ 
    rustPlatform,
    fetchFromGitHub,
    libinput,
    cairo,
    pango,
    libGL,
    systemd,
    mesa,
    libxkbcommon
}: rustPlatform.buildRustPackage {
    pname = "jay-compositor";
    version = "0.1.0";

    src = fetchFromGitHub {
        owner = "mrshiposha";
        repo = "jay";
        rev = "80dc8770c51c0409a32b212499e0803dd585cab1";
        hash = "sha256-ElohsNfBFPnZsMEsJOnqMTy5teSmdqOML2ef3NVXiaQ=";
    };

    cargoSha256 = "sha256-87MA5b0uRKa0w/J+X3fu23WhUOEQmiR4YVUwuDn/SBw=";

    buildInputs = [
        libinput
        cairo
        pango
        libGL
        systemd
        mesa
        libxkbcommon
    ];
    preConfigure = ''
        export RUSTC_BOOTSTRAP=1
    '';
}
