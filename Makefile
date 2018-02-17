all: parser.cmo lexer.cmo csv.cmo

clean:
	rm -f {lexer,parser}.ml *.cm* *.mli *.o

toplevel: all
	ocaml parser.cmo lexer.cmo csv.cmo

lexer.cmo: lexer.ml parser.cmi
	ocamlc -c lexer.ml

parser.cmo: parser.ml parser.cmi
	ocamlc -c parser.ml

csv.cmo: csv.ml parser.cmi
	ocamlc -c csv.ml

parser.cmi: parser.mli
	ocamlc -c parser.mli

parser.mli: parser.ml

lexer.ml: lexer.mll parser.cmi
	ocamllex lexer.mll

parser.ml: parser.mly
	ocamlyacc parser.mly

