{ pkgs ? import <nixpkgs> {} }: pkgs.mkShell.override {
    stdenv = pkgs.clangStdenv;
} {
    nativeBuildInputs = with pkgs; [
        pkgconfig
        openssl
        llvmPackages.bintools
        clang_11
        llvm
        nodejs
        yarn
        j2cli
    ];
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
    PROTOC = "${pkgs.protobuf}/bin/protoc";
    RUSTFLAGS = "-Clink-arg=-fuse-ld=lld";
}
