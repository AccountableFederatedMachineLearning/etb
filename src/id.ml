(* Ad-hoc binding for @peculiar/x509 *)

module X509Certificate = struct
  type t

  external make_exn :  string -> t = 
    "X509Certificate" [@@bs.new] [@@bs.module("@peculiar/x509")]

  external issuerDN :  t -> string = "issuer" [@@bs.get]

  external subjectDN :  t -> string = "subject" [@@bs.get]
end

module DN = struct
  type t

  type t_json = jsonAttributeAndValue array
  and jsonAttributeAndValue = (string array) Js.Dict.t

  external make_exn :  string -> t = 
    "Name" [@@bs.new] [@@bs.module("@peculiar/x509")]

  external to_string :  t -> string = "toString" [@@bs.send]

  external to_json :  t -> t_json = "toJSON" [@@bs.send]

  let equals n m =
    to_string m = to_string m

  let get (name : t) (key : string) : string option =
    let json = to_json name in
    Array.fold_left (fun x attrib ->
        match x with
        | None ->         
          begin match Js.Dict.get attrib key with
            | None -> None
            | Some vs -> if Array.length vs > 0 then Some vs.(0) else None            
          end
        | Some v -> Some v
      ) None json 
end

type t = { 
  subject : DN.t;
  issuer : DN.t
}

let equals i j =
  DN.equals i.subject j.subject &&
  DN.equals i.subject j.subject

let of_DNs_exn ~subjectDN ~issuerDN : t =
  { subject = DN.make_exn subjectDN;
    issuer = DN.make_exn (issuerDN)
  }

let of_x509_certificate_exn (pem : string) : t =
  let cert = X509Certificate.make_exn pem in
  of_DNs_exn 
    ~subjectDN:(X509Certificate.subjectDN cert) 
    ~issuerDN:(X509Certificate.issuerDN cert)

let to_string (id : t) : string =
  DN.to_string id.subject ^ "#" ^ DN.to_string id.issuer

let from_string_exn (s : string) : t =
  match String.split_on_char '#' s with
  | [s; i] -> 
    { subject = DN.make_exn s;
      issuer = DN.make_exn i }
  | _ -> failwith "from_string"

type t_json = {
  subject : DN.t_json;
  issuer : DN.t_json
}

let to_json (id : t) : t_json = {
  subject = DN.to_json id.subject;
  issuer = DN.to_json id.issuer
}