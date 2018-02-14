open Parser
open Lexer

let stream_of_channel c =
  let lexbuf = Lexing.from_channel c in
  let parse () = Parser.main Lexer.token lexbuf in
  Stream.from
    (fun (_:int) (* ordinal *) ->
         try                            
           Some (parse ())
         with e ->
               let _ = close_in c in
               match e with
               | Eof -> None
               | _   -> raise e)
