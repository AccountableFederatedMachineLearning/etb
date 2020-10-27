(*
Test.main "a(43, 4) :- a(43, 3). a(43, 3) :- a(43, 2). a(43, 2) :- a(43, 1). a(43, 1)."
*)

let main prg =
  let clauses = Syntax.parse_file_exn prg in
  let ls = LogicService.create clauses in
  Fabric.connect ()
  |> Js.Promise.then_ (
    LogicService.connect_to_contract ls
  ) in

main "a(101, 3) :- b(101, 2). a(101, 5) :- b(101, 4). a(101, 1)."

