{
  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, fenix, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        fenix-rust = fenix.packages.${system};
      in {
        defaultPackage.x86_64-linux = fenix-rust.minimal.toolchain;
        devShell = pkgs.mkShell {
          RUST_BACKTRACE=1;
          RUSTFLAGS="-C target-cpu=native";

          nativeBuildInputs = [
            (fenix-rust.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
          ];
        };
      });
}