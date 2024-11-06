{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            permittedInsecurePackages = [
              "segger-jlink-qt4-796s"
            ];

            allowUnfree = true;
            segger-jlink.acceptLicense = true;
          };
        };
      in
      {
        apps.default = {
          type = "app";
          program = "${pkgs.nrfconnect}/bin/nrfconnect";
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
