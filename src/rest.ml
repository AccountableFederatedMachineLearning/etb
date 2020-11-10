
let facts_get db =
  let facts = LogicService.all_facts db in
  let json_facts = List.map (fun clause -> Js.Json.string (Syntax.Cyberlogic.short_literal (Cyberlogic.head clause))) facts in
  let json_array = Js.Json.array (Array.of_list json_facts) in
  Js.Promise.resolve json_array

let facts_put db fact = 
  try 
    let lit = Syntax.Datalog.parse_literal_exn fact in    
    LogicService.add_fact db lit 
    |> Js.Promise.then_ (fun () ->
        Js.Promise.resolve ("Ok, added fact '" ^ (Syntax.Datalog.string_of_literal lit) ^ "'")
      )
  with
  | Syntax.Error err ->
    let msg = Printf.sprintf "Parsing error at line %i, column %i" err.line err.column in
    Js.Promise.resolve msg
