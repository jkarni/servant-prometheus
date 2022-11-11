{
  description = "servant-prometheus";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
  nixConfig.bash-prompt = "\[nix-develop\]$ ";
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
  let perSystem = system:
    let pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      packages.servant-prometheus = import ./servant-prometheus.nix;
      devShells.default = with pkgs;
        mkShell rec {
          buildInputs = [
            cabal2nix
          ];
        };
    };
  in flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin" "aarch64-darwin" ] perSystem;
}
