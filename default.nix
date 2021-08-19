{stdenv, ocamlPackages}:

stdenv.mkDerivation {
  name = "csv-to-orgtbl";
  version = "0.1.0";
  src = ./.;

  buildInputs = with ocamlPackages; [dune_2 ocaml];

  buildPhase = "dune build @all";

  installPhase = ''
    mkdir -p $out/bin
    cp _build/default/csv_to_orgtbl.exe $out/bin/csv_to_orgtbl
  '';

  phases = ["unpackPhase" "buildPhase" "installPhase"];
}
