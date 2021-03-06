type t

(** Turn an in_channel into a stream of string lists.  The elements of
   the list are the rows of the CSV file.  The in_channel is consumed
   and closed.  *)
val stream_of_channel:  in_channel -> t

(** Write the contents of the stream onto the channel as a table for
   emacs org mode. *)
val to_orgtbl: t -> out_channel -> unit
