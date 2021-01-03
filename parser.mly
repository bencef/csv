%token EOL
%token COMMA
%token <string> TEXT
%token <string> QUOTED_TEXT
%start main
%type <string list> main
%%
main:
  rev_fields EOL                { List.rev $1 }
;
rev_fields:
    field                   { $1 :: [] }
  | rev_fields COMMA field      { $3 :: $1 }
;
field:
    /* empty */             { "" }
  | TEXT                    { $1 }
  | QUOTED_TEXT             { $1 }
;
