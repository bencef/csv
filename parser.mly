%token EOL
%token COMMA
%token <string> TEXT
%token <string> QUOTED_TEXT
%start main
%type <string list> main
%%
main:
  fields EOL                { $1 }
;
fields:
    field                   { $1 :: [] }
  | field COMMA fields      { $1 :: $3 }
;
field:
    /* empty */             { "" }
  | TEXT                    { $1 }
  | QUOTED_TEXT             { $1 }
;
