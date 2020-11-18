open Promise

let facts_get db =
  let facts = LogicService.all_facts db in
  let json_facts = List.map Cyberlogic.(fun clause -> Literal.to_json (Clause.head clause)) facts in
  let json_array = Array.of_list json_facts in
  pure json_array

let facts_put db fact = 
  try 
    let lit = Syntax.Datalog.parse_literal_exn fact in    
    LogicService.add_fact db lit >>= fun () ->
    pure @@ "Ok, added fact '" ^ (Syntax.Datalog.string_of_literal lit) ^ "'"
  with
  | Syntax.Error err ->
    pure @@ Printf.sprintf "%s at line %i, column %i" err.msg err.line err.column

let goal_put db fact = 
  try 
    let lit = Syntax.Datalog.parse_literal_exn fact in    
    LogicService.goal db lit >>= fun () ->
    pure @@ "Ok, added goal '" ^ (Syntax.Datalog.string_of_literal lit) ^ "'"
  with
  | Syntax.Error err ->
    pure @@ Printf.sprintf "%s at line %i, column %i" err.msg err.line err.column
  | err ->
    Js.log(err);
    failwith "d"