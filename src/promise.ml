
let pure x = Js.Promise.resolve x

let (>>=) x t = Js.Promise.then_ t x

let (<*>) f x = 
  f >>= fun fv ->
  x >>= fun xv ->
  pure @@ fv xv