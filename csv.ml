open Lexer

type t = string list Stream.t

let stream_of_channel c =
  let lexbuf = Lexing.from_channel c in
  let parse () = Parser.main Lexer.token lexbuf in
  Stream.from (fun (_:int) (* ordinal *) ->
      try
        let row = parse() in
        Some row
      with e ->
            close_in c;
            match e with
            | Eof -> None
            | _   -> raise e)

let to_orgtbl stream out_c =
  let to_tblrow () = Stream.next stream
                     |> String.concat "|"
                     |> Printf.fprintf out_c "|%s|\n" in
  let header () = to_tblrow () in
  let separator () = Printf.fprintf out_c "|-\n" in
  try
    header ();
    separator ();
    while true do
      to_tblrow()
    done
  with
  | Stream.Failure -> ()
  | e -> raise e
