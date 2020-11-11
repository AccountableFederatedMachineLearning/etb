(* Ad-hoc binding for @peculiar/x509 *)

module Certificate = struct
  type t

  external make_exn :  string -> t = "X509Certificate" [@@bs.new] [@@bs.module("@peculiar/x509")]
  external issuer :  t -> string = "issuer" [@@bs.get]
  external subject :  t -> string = "subject" [@@bs.get]
end

module Name = struct
  type t

  type jsonAttributeAndValue = (string array) Js.Dict.t
  type jsonName = jsonAttributeAndValue array

  external make_exn :  string -> t = "Name" [@@bs.new] [@@bs.module("@peculiar/x509")]
  external to_string :  t -> string = "toString" [@@bs.send]
  external to_json :  t -> jsonName = "toJSON" [@@bs.send]

  let get (name : t) (key : string) : string option =
    let json = to_json name in
    Array.fold_left (fun x d ->
        match x with
        | None -> 
          begin match Js.Dict.get d key with
            | None -> None
            | Some vs -> if Array.length vs > 0 then Some vs.(0) else None
          end
        | Some v -> Some v) None json 
end


type t = {
  subject : Name.t;
  issuer : Name.t
}

let of_DNs_exn (subjectDN : string) (issuerDN : string) : t =
  { subject = Name.make_exn subjectDN;
    issuer = Name.make_exn (issuerDN)
  }

let of_x509_certificate_exn (pem : string) : t =
  let cert = Certificate.make_exn pem in
  of_DNs_exn (Certificate.subject cert) (Certificate.issuer cert)

let to_string (id : t) : string =
  Name.to_string id.subject ^ "#" ^ Name.to_string id.issuer

exception Id_Format

let from_string_exn (s : string) : t =
  match String.split_on_char '#' s with
  | [s; i] -> { subject = Name.make_exn s;
                issuer = Name.make_exn i
              }
  | _ -> raise Id_Format

(*
let _ =
  try
  let pem ="-----BEGIN CERTIFICATE-----\nMIIChDCCAiqgAwIBAgIUPJpyVFxw6rq4urzw0bagRlEJi5swCgYIKoZIzj0EAwIw\ncDELMAkGA1UEBhMCVVMxFzAVBgNVBAgTDk5vcnRoIENhcm9saW5hMQ8wDQYDVQQH\nEwZEdXJoYW0xGTAXBgNVBAoTEG9yZzEuZXhhbXBsZS5jb20xHDAaBgNVBAMTE2Nh\nLm9yZzEuZXhhbXBsZS5jb20wHhcNMjAxMDMxMDY0ODAwWhcNMjExMDMxMDY1MzAw\nWjBEMTAwDQYDVQQLEwZjbGllbnQwCwYDVQQLEwRvcmcxMBIGA1UECxMLZGVwYXJ0\nbWVudDExEDAOBgNVBAMTB2FwcFVzZXIwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNC\nAARuJROMZnVTHyddecaB2t4NybGpTOeWQGzzU2LtVBdBdYobZifsvC38tf2Z3oM8\nfxaPmqnpA4hJMT2/+FZXodTco4HNMIHKMA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMB\nAf8EAjAAMB0GA1UdDgQWBBRzXZOB/KSuRnXbF1Xwsr/b5LmSMTAfBgNVHSMEGDAW\ngBT5UNugs5n3PHAIZ65Wepoqv9jlnjBqBggqAwQFBgcIAQReeyJhdHRycyI6eyJo\nZi5BZmZpbGlhdGlvbiI6Im9yZzEuZGVwYXJ0bWVudDEiLCJoZi5FbnJvbGxtZW50\nSUQiOiJhcHBVc2VyIiwiaGYuVHlwZSI6ImNsaWVudCJ9fTAKBggqhkjOPQQDAgNI\nADBFAiEAov+58a4a76JKDEBtlUepeWY8o5VzysbK5Jd58GlCmLQCIALODVDYVjWz\nmOkjlxfGMW4Vw+KXOjAXfZmj5kn7AEyt\n-----END CERTIFICATE-----\n" in
  let cert = mk_certificate_exn pem in
  let name = mk_name_exn "CN=edewd" in
  Js.log (Js.Dict.keys (to_json name).(0) );
  Js.log (to_string name);
  Js.log (subject cert);
  Js.log (issuer cert)
  with e -> Js.log(e)
  *)