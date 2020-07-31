let () =
  let csv = Csv.stream_of_channel stdin in
  Csv.to_orgtbl csv stdout
