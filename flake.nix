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
        defaultPackage = pkgs.writeShellApplication {
          name = "today";
          runtimeInputs = [ pkgs.nushell ];
          text = "nu ./today.nu";
        };


      });
}
