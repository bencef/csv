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

let to_orgtbl out_c in_c =
  let to_tblrow () = Stream.next in_c
                     |> String.concat "|"
                     |> Printf.fprintf out_c "|%s|\n" in
  let header () = to_tblrow () in
  let separator () = Printf.fprintf out_c "|-\n" in
  try
    header ();
    separator ();
    while true
    do
      to_tblrow ()
    done
  with e -> match e with
            | Stream.Failure -> ()
            | _ -> raise e
