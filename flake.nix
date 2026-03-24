{
  description = "Convert CSV from Standard In into Org-mode tables on Standard Out.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";
  };

  outputs = {self, nixpkgs, flake-utils, nix-filter, ...} :
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [
        (final: prev: {
          ocamlPackages = final.ocaml-ng.ocamlPackages_5_3;
        })
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
    in {
      packages.default = pkgs.callPackage ./default.nix { nix-filter = nix-filter.lib; };
      devShells.default = pkgs.mkShell {
        inputsFrom = [ self.packages.${system}.default ];
        packages =
          let
            ocamlDeps = with pkgs.ocamlPackages; [ findlib
                                                   utop
                                                   ocaml-lsp
                                                   ocamlformat
                                                 ];
            deps = with pkgs; [ python3 ];
          in deps ++ ocamlDeps;
      };
    });
}
