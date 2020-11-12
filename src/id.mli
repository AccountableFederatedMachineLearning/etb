(** X509 Certificates *)
module X509Certificate : sig
  type t

  (** Make certificate from pem *)
  val make_exn :  string -> t

  val issuerDN :  t -> string
  val subjectDN :  t -> string
end

(** Distinguished Names *)
module DN : sig
  type t

  type t_json = jsonAttributeAndValue array
  and jsonAttributeAndValue = (string array) Js.Dict.t

  val make_exn :  string -> t 
  val to_string :  t -> string
  val to_json :  t -> t_json

  val get : t -> string -> string option

end

(** Identity *)
type t = {
  subject : DN.t;
  issuer : DN.t
}

type t_json = {
  subject : DN.t_json;
  issuer : DN.t_json
}

val of_DNs_exn : subjectDN : string -> issuerDN : string -> t

val of_x509_certificate_exn : string -> t

val to_string : t -> string

val from_string_exn : string -> t

val to_json : t -> t_json