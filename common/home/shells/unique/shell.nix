{ pkgs ? import <nixpkgs> {} }: pkgs.mkShell.override {
    stdenv = pkgs.clangStdenv;
} {
    nativeBuildInputs = with pkgs; [
        pkgconfig
        openssl
        llvmPackages.bintools
        clang_11
        llvm
        nodejs-16_x
        (yarn.override {nodejs = nodejs-16_x;})
    ];
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
    PROTOC = "${pkgs.protobuf}/bin/protoc";
    RUSTFLAGS = "-Clink-arg=-fuse-ld=lld";
}
