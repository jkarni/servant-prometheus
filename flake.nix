{
  description = "servant-prometheus";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = github:NixOS/nixpkgs/master;
  nixConfig.bash-prompt = "\[nix-develop\]$ ";
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
  let perSystem = system:
    let pkgs = nixpkgs.legacyPackages.${system};
        compiler = "ghc924";
        haskellPackages = pkgs.haskell.packages.${compiler};
    in rec {
      packages.servant-prometheus = haskellPackages.callPackage ./servant-prometheus.nix {};
      devShells.default = with pkgs;
        mkShell {
          buildInputs = [
            cabal2nix
            haskellPackages.cabal-install
            (haskellPackages.ghc.withPackages (p:
              packages.servant-prometheus.getBuildInputs.haskellBuildInputs
            ))
          ];
        };
    };
  in flake-utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin" "aarch64-darwin" ] perSystem;
}
