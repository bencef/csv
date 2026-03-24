{stdenv, ocamlPackages, nix-filter ? null}:

stdenv.mkDerivation {
  name = "csv-to-orgtbl";
  version = "0.1.0";
  src = if nix-filter == null
        then ./.
        else (nix-filter {
          root = ./.;
          include = [
            ./csv.ml
            ./csv.mli
            ./csv_to_orgtbl.ml
            ./dune
            ./dune-project
            ./lexer.mll
            ./parser.mly
          ];
        });

  buildInputs = with ocamlPackages; [dune_2 ocaml];

  buildPhase = "dune build @all";

  installPhase = ''
    mkdir -p $out/bin
    cp _build/default/csv_to_orgtbl.exe $out/bin/csv_to_orgtbl
  '';

  phases = ["unpackPhase" "buildPhase" "installPhase"];

  meta = {
    mainProgram = "csv_to_orgtbl";
  };
}
