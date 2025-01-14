{
  cargo-prove,
  # gcc,
  lib,
  openssl,
  pkg-config,
  sp1-rust-toolchain,
  mkShell,
  git,
}:
mkShell {
  buildInputs = [
    # sp1
    cargo-prove
    sp1-rust-toolchain
    # other
    # gcc
    openssl
    pkg-config
    git
  ];

  # shellHook = ''
  #   export OPENSSL_DIR="${openssl.dev}"
  #   export OPENSSL_LIB_DIR="${openssl.out}/lib"
  #   export OPENSSL_INCLUDE_DIR="${openssl.dev}/include"
  #   export LD_LIBRARY_PATH="${lib.makeLibraryPath [ openssl ]}:$LD_LIBRARY_PATH"
  # '';
}

