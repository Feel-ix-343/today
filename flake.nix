{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      in
      {

        defaultPackage = pkgs.stdenv.mkDerivation {
            name = "today";
            src = ./.;
            buildInputs = [ pkgs.nushell ];

            installPhase = ''
              mkdir -p $out/bin
              cp today.nu $out/bin/today
              chmod +x $out/bin/today
            '';

          };


      });
}
