all: parser.cmo lexer.cmo

clean:
	rm -f *.ml *.cm* *.mli

lexer.cmo: lexer.ml parser.cmi
	ocamlc -c lexer.ml

parser.cmo: parser.ml parser.cmi
	ocamlc -c parser.ml

parser.cmi: parser.mli
	ocamlc -c parser.mli

parser.mli: parser.ml

lexer.ml: lexer.mll parser.cmi
	ocamllex lexer.mll

parser.ml: parser.mly
	ocamlyacc parser.mly

