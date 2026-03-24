{
open Parser
exception Eof

let unquote s =
  let len = String.length s - 2 in
  let trimmed = String.sub s 1 len in
  let unescape_quotes text =
    String.split_on_char '"' text
    |> List.map (fun s -> if String.equal String.empty s then "\"" else s)
    |> String.concat String.empty in
  unescape_quotes trimmed
}
rule token = parse
    '\r' ? '\n'                             { EOL }
  | ','                                     { COMMA }
  | [ ^ '"' ',' '\r' '\n' ] +          as t { TEXT(t) }
  | '"' ( [ ^ '"' ] | '"' '"' ) * '"'  as t { QUOTED_TEXT(unquote t) }
  | eof                                     { raise Eof }
