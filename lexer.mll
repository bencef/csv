{
open Parser
exception Eof

let trim s =
  let len = String.length s - 2 in
    String.sub s 1 len
}
rule token = parse
    '\r' ? '\n'                             { EOL }
  | ','                                     { COMMA }
  | [ ^ '"' ',' '\r' '\n' ] +          as t { TEXT(t) }
  | '"' ( [ ^ '"' ] | '"' '"' ) * '"'  as t { QUOTED_TEXT(trim t) }
  | eof                                     { raise Eof }
