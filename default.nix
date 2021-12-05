let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  ruststable = (nixpkgs.latest.rustChannels.stable.rust.override {
    extensions = [
      "rust-src"
      "rustfmt-preview"
      "clippy-preview"
    ];
  });
in
with nixpkgs;
mkShell rec {
  buildInputs = [
    #rust-analyzer
    ruststable
  ]
  ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    CoreServices
  ]);
}
