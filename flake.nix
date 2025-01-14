{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    sp1-src = {
      url = "github:succinctlabs/sp1";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs:
    let
      overlays = [ inputs.self.overlays.default ];
      perSystemPkgs =
        f:
        inputs.nixpkgs.lib.genAttrs (import inputs.systems) (
          system: f (import inputs.nixpkgs { inherit overlays system; })
        );
    in
    {
      overlays = {
        my-overlay = import ./overlay.nix { inherit (inputs) sp1-src; };
        default = inputs.self.overlays.my-overlay;
      };

      packages = perSystemPkgs (pkgs: {
        cargo-prove = pkgs.cargo-prove;
        sp1-rust-toolchain = pkgs.sp1-rust-toolchain;
      });

      devShells = perSystemPkgs (pkgs: { 
          dev = pkgs.callPackage ./pkgs/shell.nix { };
          default = inputs.self.devShells.${pkgs.system}.dev;
      });

      formatter = perSystemPkgs (pkgs: pkgs.nixfmt-rfc-style);
    };
}
