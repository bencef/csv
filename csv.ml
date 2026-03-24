open Lexer

type t = string list Seq.t

let stream_of_channel c =
  let lexbuf = Lexing.from_channel c in
  let parse () = Parser.main Lexer.token lexbuf in
  Seq.of_dispenser (fun () ->
      try
        let row = parse() in
        Some row
      with e ->
            close_in c;
            match e with
            | Eof -> None
            | _   -> raise e)

let to_orgtbl stream out_c =
  match Seq.uncons stream with
  | None -> exit 1
  | Some (header_titles, stream) -> (
    let to_tblrow line =
      line
      |> String.concat "|"
      |> Printf.fprintf out_c "|%s|\n" in
    let header () = to_tblrow header_titles in
    let separator () = Printf.fprintf out_c "|-\n" in
    header ();
    separator ();
    Seq.iter to_tblrow stream
  )
