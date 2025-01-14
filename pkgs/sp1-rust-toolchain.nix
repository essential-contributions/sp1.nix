{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  xz,
  zlib,
  ncurses,
  gcc-unwrapped,
}:

stdenv.mkDerivation rec {
  pname = "sp1-rust-toolchain";
  version = "1.81.0";

  src = fetchurl {
    url = "https://github.com/succinctlabs/rust/releases/download/v${version}/rust-toolchain-aarch64-apple-darwin.tar.gz";
    sha256 = "sha256-tVvf3syK18uRLp3Idam3oqjcZvB13JBoXBkskbkQQZQ=";
  };

  # nativeBuildInputs = [
  #   autoPatchelfHook
  # ];
  # nativeBuildInputs = lib.optionals stdenv.isLinux [
  #   autoPatchelfHook
  # ];

  # buildInputs = [
  # ] ++ lib.optionals stdenv.isLinux [
  #   xz
  #   zlib
  #   ncurses
  #   gcc-unwrapped
  #   stdenv.cc.cc.lib
  # ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib
    cp -r bin/* $out/bin/
    cp -r lib/* $out/lib/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Succinct Labs Rust toolchain";
    homepage = "https://github.com/succinctlabs/rust";
    license = licenses.mit;
    platforms = [ "x86_64-linux" "aarch64-darwin" ];
  };
}
